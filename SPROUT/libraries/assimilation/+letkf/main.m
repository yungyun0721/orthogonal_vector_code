%% [analysis, addition] = letkf.main(model,obs_collection,settings,obs_time,material);
%
% Local Ensemble Transform Kalman Filter
%
% <output>
% analysis (ensemble analysis)
% addition.innovation
% addition.mean_weighting
% addition.perturbation_weighting
% addition.update_xindex

%%
function [analysis, addition]=main(model,obs_collection,settings,obs_time,material)
%% Local Ensemble Transform Kalman Filter
    % get basic element
    msv = model.emsv(settings.analyze_vars);
    osv = obs_collection.osv(settings.analyze_vars,obs_time,model,msv);
    yb_perturbation = osv.yb_perturbation;
    innovation = osv.innovation;
    K = model.settings.ensemble.members;
    
    % perform ETKF for each grid point
    mean_weighting         = cell(1,sum(msv.mss));
    perturbation_weighting = cell(1,sum(msv.mss)); 
    mci_factor = settings.etkf.analyzer.mci_factor;
    sqrt_mode  = settings.etkf.analyzer.sqrt_mode;
    y_local_index = material.letkf.y_local_index;
    locR          = material.letkf.locR;
    obs_available = material.letkf.obs_available;
    
    update_xindex = letkf.get_xindex_to_update(settings,msv.mss,obs_available);

    % prepare parallel computation perform analyze
    temp_mw  = cell(1,length(update_xindex));
    temp_pw  = cell(1,length(update_xindex));
    temp_yli = cell(1,length(update_xindex));
    temp_locR = cell(1,length(update_xindex));
    for uxnum = 1:length(update_xindex)
        temp_yli{uxnum} = y_local_index{update_xindex(uxnum)};
        temp_locR{uxnum} = locR{update_xindex(uxnum)};
    end
    %parfor uxnum = 1:length(update_xindex)
    for uxnum = 1:length(update_xindex)
        % get loacl xb and obs
        loc = letkf.selector(temp_yli{uxnum},yb_perturbation,innovation);
        % get weighting
        [temp_mw{uxnum}, temp_pw{uxnum}] = etkf.analyzer(K,temp_locR{uxnum},loc.yb_perturbation,loc.innovation,mci_factor,sqrt_mode);
    end
    mean_weighting(update_xindex)         = temp_mw;
    perturbation_weighting(update_xindex) = temp_pw;
    
    % get analysis mean and perturbation state
    [xa_mean, xa_perturbation] = letkf.updator(msv.xb_mean,msv.xb_perturbation,mean_weighting,perturbation_weighting,update_xindex);

    % inflation
    xa_perturbation = da.inflation(settings,xa_perturbation);

    % combine
    xa = bsxfun(@plus,xa_perturbation,xa_mean);

%% package output
    % analysis
    analysis = da.fold_ensemble_background(xa,msv.background,msv.mss,settings.model_vars);
    
    % addition
    addition.innovation = innovation;
    addition.mean_weighting = mean_weighting;
    addition.perturbation_weighting = perturbation_weighting;
    addition.update_xindex = update_xindex;
end
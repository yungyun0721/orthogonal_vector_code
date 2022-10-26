%% [analysis, addition] = etkf.main(model,obs_collection,settings,obs_time);
%
% Ensemble Transform Kalman Filter
% this is newer and seperating the analyze process version
% make easiler to implement Smoother and WIAU
%
% <output>
% analysis (ensemble analysis)
% addition.innovation
% addition.mean_weighting
% addition.perturbation_weighting

%%
function [analysis, addition]=main(model,obs_collection,settings,obs_time)
%%  Ensemble Transform Kalman Filter
    % get basic element
    msv = model.emsv(settings.analyze_vars);
    osv = obs_collection.osv(settings.analyze_vars,obs_time,model,msv);
    K = model.settings.ensemble.members;
    
    % get weighting
    mci_factor = settings.etkf.analyzer.mci_factor;
    sqrt_mode  = settings.etkf.analyzer.sqrt_mode;
    [mean_weighting, perturbation_weighting] = ...
                                    etkf.analyzer(K,osv.R,osv.yb_perturbation,osv.innovation,mci_factor,sqrt_mode);
    
    % get analysis mean and perturbation state
    [xa_mean, xa_perturbation] = etkf.updator(msv.xb_mean,msv.xb_perturbation,mean_weighting,perturbation_weighting);

    % inflation
    xa_perturbation = da.inflation(settings,xa_perturbation);

    % combine
    xa = bsxfun(@plus,xa_perturbation,xa_mean);

%%  package output
    % analysis
    analysis = da.fold_ensemble_background(xa,msv.background,msv.mss,settings.model_vars);
    
    % addition
    addition.innovation = osv.innovation;
    addition.mean_weighting = mean_weighting;
    addition.perturbation_weighting = perturbation_weighting;
end
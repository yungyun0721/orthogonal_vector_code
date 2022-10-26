%% [analysis, addition, material] = etkis.main(model, settings, material);
%
% Ensemble Transform Kalman Incremental Smoother
%
% <output>
% analysis (ensemble analysis)
% material (updated material.incremental.passed_step)

%%
function [analysis, addition, material] = main(model,settings,material)
    %% pre-perform Ensemble Transform Kalman Filter
    now_step               = material.etkis.passed_step+1;
    mean_weighting         = material.etkis.mean_weighting{now_step};
    perturbation_weighting = material.etkis.perturbation_weighting;
    
    %% Incremental Ensemble Transform Kalman Smoother
    % get basic element
    msv = model.emsv(settings.analyze_vars);
    
    % get analysis mean and perturbation state
    [xa_mean, xa_perturbation] = etkf.updator(msv.xb_mean,msv.xb_perturbation,mean_weighting,perturbation_weighting);

    % inflation
    xa_perturbation = da.inflation(settings,xa_perturbation);

    % combine
    xa = bsxfun(@plus,xa_perturbation,xa_mean);

    %% package output
    % analysis
    analysis = da.fold_ensemble_background(xa,msv.background,msv.mss,settings.model_vars);
    
    % addition
    addition = [];
    
    % material
    material.etkis.passed_step = now_step;
end
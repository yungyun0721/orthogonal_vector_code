%% [analysis, addition] = etks.main(model,settings,material);
%
% Ensemble Transform Kalman Smoother
%
% <output>
% analysis (ensemble analysis)

%%
function [analysis, addition] = main(model,settings,material)
    %% pre-perform Ensemble Transform Kalman Filter
    mean_weighting = material.etks.mean_weighting;
    perturbation_weighting = material.etks.perturbation_weighting;
    
    %% Ensemble Transform Kalman Smoother
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
end
%% [xa_mean, xa_perturbation] = etkf.updator(xb_mean,xb_perturbation,mean_weighting,perturbation_weighting);
%
% part of Ensemble Transform Kalman Filter

%%
function [xa_mean, xa_perturbation]=updator(xb_mean,xb_perturbation,mean_weighting,perturbation_weighting)
%%  update
    % mean
    xa_mean = xb_mean + xb_perturbation*mean_weighting;

    % perturbation
    xa_perturbation = xb_perturbation*perturbation_weighting;
end
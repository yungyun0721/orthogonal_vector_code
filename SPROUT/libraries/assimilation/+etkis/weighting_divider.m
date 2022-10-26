%% [mean_weighting, perturbation_weighting] = etkis.weighting_divider(all_steps,OPW,OMW)
%
% part of Ensemble Transform Kalman Incremental Smoother
% also support Local Ensemble Transform Kalman Incremental Smoother
%
% all_steps
% OPW = original_perturbation_weighting
% OMW = original_mean_weighting

function [mean_weighting, perturbation_weighting] = weighting_divider(all_steps,OPW,OMW)
    [v,d] = eig(round(OPW*(2^32))/(2^32));
    perturbation_weighting = v*d^(1.0/all_steps)*v';
    
    mean_weighting = cell(1,all_steps);
    for step = 1:all_steps
        mean_weighting{step} = v*d^(-(step-1)/all_steps)*v'*OMW/all_steps;
    end
end
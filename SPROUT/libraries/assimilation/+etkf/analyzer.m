%% [mean_weighting, perturbation_weighting] = etkf.analyzer(K,R,yb_perturbation,innovation,mci_factor);
%
% Core of Ensemble Transform Kalman Filter
%
% K : ensemble size
% R : observation error covariance
% yb_perturbation : background at observation space
% innovation : difference between model and observation
% mci_factor : multiplicative covariance inflation factor
%              save in da_settings.etkf.analyzer.mci_factor
% sqrt_mode : 1 (accurate), use sqrtm to get sqrt(D) matrix
%           : 2 (speedy), use eigen decomposition to calculate sqrt(D) matrix
%           : 3 (speedy), calculate D^0.5 matrix directly
%             save in da_settings.etkf.analyzer.sqrt_mode

%%
function [mean_weighting, perturbation_weighting]=analyzer(K,R,yb_perturbation,innovation,mci_factor,sqrt_mode)
    C = yb_perturbation'/R;
    invD = (eye(K)*(K-1)/mci_factor)+C*yb_perturbation;
    mean_weighting = invD\C*innovation;
    
    switch sqrt_mode
        case 1
            perturbation_weighting = sqrtm(invD\(eye(K)*(K-1)));
        case 2 
            [v, d] = eig(round(invD\(eye(K)*(K-1))*(2^32))/(2^32));
            perturbation_weighting = v*d^(1/2)*v';
        case 3
            perturbation_weighting = (round(invD\(eye(K)*(K-1))*(2^32))/(2^32))^(0.5);
        otherwise
            error('etkf.analyzer : no corresponding mode')
    end
end
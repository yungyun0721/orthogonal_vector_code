%% loc = letkf.selector(xindex,material,yb_perturbation,innovation);
%
% part of Local Ensemble Transform Kalman Filter
%
% <output>
% loc.yb_perturbation
% loc.innovation

%%
function loc=selector(y_local_index,yb_perturbation,innovation)
    loc.yb_perturbation = yb_perturbation(y_local_index,:);
    loc.innovation = innovation(y_local_index);
end
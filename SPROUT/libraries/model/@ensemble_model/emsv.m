%% emsv = obj.msv(select_vars);
% 
% <output>
% msv.type
% msv.mss
% msv.xb_mean
% msv.xb_perturbation
% msv.background

%%
function emsv_ouput = emsv(obj,select_vars)
    % xb, mss
    background = obj.ensmember;
    [xb, mss] = da.unfold_ensemble_background(background,select_vars);
    
    % xb_mean, xb_perturbation
    xb_mean = mean(xb,2);
    xb_perturbation = bsxfun(@minus,xb,xb_mean);
    
    % package - model space variables (msv)
    emsv_ouput.type            = 'ensemble';
    emsv_ouput.mss             = mss;
    emsv_ouput.xb_mean         = xb_mean;
    emsv_ouput.xb_perturbation = xb_perturbation;
    emsv_ouput.background      = background;
end
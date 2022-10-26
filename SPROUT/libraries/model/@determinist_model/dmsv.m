%% msv = obj.dmsv(select_vars);
% 
% <output>
% msv.type
% msv.mss
% msv.xb
% msv.background

%%
function dmsv_ouput = dmsv(obj,select_vars)
    % xb, mss
    background = obj.ensmember;
    [xb, mss] = da.unfold_background(background,select_vars);
    
    % package - model space variables (msv)
    dmsv_ouput.type       = 'determinist';
    dmsv_ouput.mss        = mss;
    dmsv_ouput.xb         = xb;
    dmsv_ouput.background = background;
end
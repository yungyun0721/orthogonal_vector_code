%% msv = obj.osv(observation_vars,obs_time,model,msv);
% 
% <output>
% osv.R
% osv.innovation
% osv.yb_perturbation (only for ensemble_model)

%%
function osv_ouput = osv(obj,observation_vars,obs_time,model,msv)
    % obs, oss
    aot_observation = obj.aot_observation(obs_time);
    [obs, oss] = da.unfold_observation(aot_observation,observation_vars);

    % H, R
    H = da.build_obs_transporter(model,obj,msv.mss,oss);
    osv_ouput.R = da.build_obs_variance(obj,oss);

    % innovation
    switch msv.type
        case 'determinist'
            yb = H*msv.xb;
            innovation = obs-yb;
            osv_ouput.innovation = innovation;
        case 'ensemble'
            yb_mean = H*msv.xb_mean;
            innovation = obs-yb_mean;
            osv_ouput.innovation = innovation;
        otherwise
    end

    % yb_perturbation
    if strcmp(msv.type,'ensemble')
        yb_perturbation = H*msv.xb_perturbation;
        osv_ouput.yb_perturbation = yb_perturbation;
    end
end
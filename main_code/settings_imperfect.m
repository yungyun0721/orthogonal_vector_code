function [model_settings, obs_settings, da_settings] = settings_imperfect()
    %% model_settings
    model_settings.dynamic       = 'lorenz96';
    model_settings.final_records = 201;
    % map
    model_settings.map_args.x.domain_size  = 360;
    model_settings.map_args.x.domain_start = 360/40/2;%
    model_settings.map_args.x.grid_points  = 40;%
    model_settings.map_args.y.domain_size  = 360;
    model_settings.map_args.y.domain_start = 360/40/2;%
    model_settings.map_args.y.grid_points  = 40;%
    % parm
    model_settings.parm_args.c = 0;
    model_settings.parm_args.b = 10;
    model_settings.parm_args.f = 7.8;
    model_settings.parm_args.h = 1;
    % ensemble
    model_settings.ensemble.members = 6;
    model_settings.ensemble.det2ens.timeshift.enable = 1;
    model_settings.ensemble.det2ens.timeshift.steps  = 20;
    model_settings.ensemble.det2ens.perturb.enable     = 1;
    model_settings.ensemble.det2ens.perturb.rng.enable = 1;
    model_settings.ensemble.det2ens.perturb.rng.seeds  = 0;
    model_settings.ensemble.det2ens.perturb.unbias     = 1;
    model_settings.ensemble.det2ens.perturb.resize     = 1;
    model_settings.ensemble.det2ens.perturb.perturbation{1} = 1.5;%
    model_settings.ensemble.det2ens.perturb.perturbation{2} = 0.2;
    % integrator
    model_settings.integrator.step_size = 0.01;%
    model_settings.integrator.save_traj = 1;
    
    %% obs_settings
    % observed_vars
    obs_settings.observed_vars           = [1 2];
    % X
    obs_settings.vars{1}.resize          = 0;
    obs_settings.vars{1}.unbias          = 0;
    obs_settings.vars{1}.rng.enable      = 1;
    obs_settings.vars{1}.rng.seeds       = 30;   %120; %23(24hr) 64 120(36hr) 30
    obs_settings.vars{1}.perturbation    = 1;    %observation error
    obs_settings.vars{1}.space.mode      = 'gridpoint';
    obs_settings.vars{1}.space.gridpoint = 1:2:40;    %
    obs_settings.vars{1}.time.mode       = 'interval';
    obs_settings.vars{1}.time.interval   = 30;       %DA_time 30
    % Y
    obs_settings.vars{2}.resize          = 0;
    obs_settings.vars{2}.unbias          = 0;
    obs_settings.vars{2}.rng.enable      = 1;
    obs_settings.vars{2}.rng.seeds       = 0;
    obs_settings.vars{2}.perturbation    = 0.05;
    obs_settings.vars{2}.space.mode      = 'interval';
    obs_settings.vars{2}.space.interval  = 1;
    obs_settings.vars{2}.time.mode       = 'interval';
    obs_settings.vars{2}.time.interval   = 30;      
    
    %% da_settings 
    da_settings.model_vars       = [1];
    da_settings.observation_vars = [1];
    da_settings.analyze_method   = 'LETKF';
    da_settings.inflation.multiplicative = 0;%perturbation inflation
    da_settings.etkf.analyzer.mci_factor = 2.3;%1.15;%1.25 (all obs 36hr)  %covarience inflation
    da_settings.etkf.analyzer.sqrt_mode  = 1;
    da_settings.dc.dim_distance_plus = [0 0 ; 0 0];
    da_settings.dc.dim_distance_multi = [1 0 ; 0 1];
    da_settings.letkf.truncation_distance = [45 0];%
    da_settings.letkf.rlocalization.enable = 1;
    da_settings.letkf.rlocalization.radius = [12.5 22.5];
    da_settings = da.settings_finisher(da_settings);
end
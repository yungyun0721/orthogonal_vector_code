function [truth, DetInitial, EnsInitial, observation, NEItemp] = NormalExperimentInitializer(model_settings,obs_settings,truth_steps)
    %% spin-up
    disp('state : spin-up')
    raw.vars{1} = sin((1:model_settings.map_args.x.grid_points)*2)*5;
    raw.vars{2} = sin(1:model_settings.map_args.y.grid_points)*0.2;

    rng(160)
    noise.vars{1} = randn(size(raw.vars{1}))*2;
    noise.vars{2} = randn(size(raw.vars{2}))*0.1;

    spinup = determinist_model(raw,model_settings);
    spinup = spinup.integrate(500);
    test_spinup = spinup;
    test_spinup.determinist = test_spinup.determinist.add_increment(noise,1,0);
    test_spinup.settings.integrator.save_traj = 1;
    spinup = spinup.integrate(500);
    test_spinup  = test_spinup.integrate(500);
    %% prepare initial field
    disp('state : prepare initial field')
    ensmember = det2ens.main(model_settings,test_spinup);
    % ensmember = det2ens.perturb(model_settings,test_spinup.determinist);
    % ensmember = det2ens.timeshift(model_settings,test_spinup);

    %% create model obj
    disp('state : create model obj')
    EnsInitial = ensemble_model(ensmember,model_settings);
    EnsInitial = EnsInitial.refresh_ensmean;
    noise_initial.vars = EnsInitial.ensmean.vars;
    DetInitial = determinist_model(noise_initial,model_settings);
        model_settings.integrator.save_traj = 1;
        model_settings.final_records = 1001;
    truth = determinist_model(spinup.determinist,model_settings);
    %% prepare observation
    disp('state : prepare observation')
    truth = truth.integrate(truth_steps);
    observation = observation_collection(truth.determinist,obs_settings);
    
    %% package temp vars
    NEItemp.raw = raw;
    NEItemp.noise = noise;
    NEItemp.spinup = spinup;
    NEItemp.test_spinup = test_spinup;
    NEItemp.ensmember = ensmember;
    NEItemp.noise_initial = noise_initial;
end
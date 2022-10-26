%% [model, material] = etks.preinitializer(model,obs_collection,settings,analyze_time);
%
% part of Ensemble Transform Kalman Smoother
%
% <related settings>
% (all in ETKF)
% settings.smoother.record.background
% settings.smoother.record.pre_analysis
%
% <output>
% material.etks.mean_weighting (from ETKF analysis at observation time)
% material.etks.perturbation_weighting (from ETKF analysis at observation time)
% model record : background_at_obs_time (if settings.smoother.record.background is true)
% model record : etkf_analysis_at_obs_time (if settings.smoother.record.pre_analysis is true)

%%
function [model, material] = preinitializer(model,obs_collection,settings,analyze_time)
    %% save initial state
    initial_model = model;
    
    %%  integrate to observation time
    original_save_traj = model.settings.integrator.save_traj;
    model.settings.integrator.save_traj = settings.smoother.record.save_traj;
    fsteps = round((analyze_time-model.time)/model.settings.integrator.step_size);
    model = model.gathered_integrate(fsteps);
    
    if settings.smoother.record.background
        model = model.add_record('background_at_obs_time');
    end

    %%  pre-perform Ensemble Transform Kalman Filter
    settings.analyze_method = 'ETKF';
    etkf_analysis = ensemble_analysis(model,obs_collection,settings,model.time);
    material.etks.mean_weighting = etkf_analysis.addition.mean_weighting;
    material.etks.perturbation_weighting = etkf_analysis.addition.perturbation_weighting;
    
    if settings.smoother.record.pre_analysis
        model = model.update_ensemble(etkf_analysis);
        model = model.add_record('etkf_analysis_at_obs_time');
    end

    %% revert
    model = model.revert_by_model(initial_model);
    model.settings.integrator.save_traj = original_save_traj;
end
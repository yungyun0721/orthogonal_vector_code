%% [model, material] = letks.preinitializer(model,obs_collection,settings,analyze_time,material);
%
% part of Ensemble Transform Kalman Smoother
%
% <related settings>
% (all in LETKF)
% settings.smoother.record.background
% settings.smoother.record.pre_analysis
%
% <output>
% material.letks.mean_weighting (from LETKF analysis at observation time)
% material.letks.perturbation_weighting (from LETKF analysis at observation time)
% material.letks.update_xindex
% model record : background_at_obs_time (if settings.smoother.record.background is true)
% model record : letkf_analysis_at_obs_time (if settings.smoother.record.pre_analysis is true)

%%
function [model, material] = preinitializer(model,obs_collection,settings,analyze_time,material)
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

    %%  pre-perform Local Ensemble Transform Kalman Filter
    settings.analyze_method = 'LETKF';
    letkf_analysis = ensemble_analysis(model,obs_collection,settings,model.time,material);
    material.letks.mean_weighting = letkf_analysis.addition.mean_weighting;
    material.letks.perturbation_weighting = letkf_analysis.addition.perturbation_weighting;
    material.letks.update_xindex = letkf_analysis.addition.update_xindex;
    
    if settings.smoother.record.pre_analysis
        model = model.update_ensemble(letkf_analysis);
        model = model.add_record('letkf_analysis_at_obs_time');
    end

    %% revert
    model = model.revert_by_model(initial_model);
    model.settings.integrator.save_traj = original_save_traj;
end
%% [model, material] = letkis.preinitializer(model,obs_collection,settings,analyze_time,material);
%
% part of Ensemble Transform Kalman Incremental Smoother
%
% <related settings>
% (all in LETKF)
% settings.smoother.record.background
% settings.smoother.record.pre_analysis
% settings.ismoother.all_steps
%
% <output>
% material.letkis.mean_weighting
% material.letkis.perturbation_weighting
% material.letkis.update_xindex
% material.letkis.passed_step
%
% <modify model>
% add record : background_at_obs_time (if settings.smoother.record.background is true)
% add record : etkf_analysis_at_obs_time (if settings.smoother.record.pre_analysis is true)

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

    % prepare incremental weighting
    all_steps = settings.ismoother.all_steps;
    OPW = letkf_analysis.addition.perturbation_weighting;
    OMW = letkf_analysis.addition.mean_weighting;
    wlength = length(OPW);
    mean_weighting = cell(all_steps,wlength);
    perturbation_weighting = cell(1,wlength);
    parfor windex = 1:wlength
        [mean_weighting(:,windex), perturbation_weighting{windex}] = ...
                        etkis.weighting_divider(all_steps,OPW{windex},OMW{windex});
    end
    material.letkis.mean_weighting = mean_weighting;
    material.letkis.perturbation_weighting = perturbation_weighting;
    material.letkis.update_xindex = letkf_analysis.addition.update_xindex;
    
    if settings.smoother.record.pre_analysis
        model = model.update_ensemble(letkf_analysis);
        model = model.add_record('letkf_analysis_at_obs_time');
    end

    %% revert
    model = model.revert_by_model(initial_model);
    model.settings.integrator.save_traj = original_save_traj;
    
    %% passed_step
    material.letkis.passed_step = 0;
end
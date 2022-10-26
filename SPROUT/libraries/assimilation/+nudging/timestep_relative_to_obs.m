function timesteps = timestep_relative_to_obs(model,obs_time)
    model_time = model.time;
    model_timestep_size = model.settings.integrator.step_size;

    time_diff = model_time-obs_time;
    timesteps = round(time_diff/model_timestep_size*100)/100;
end
function timesteps = integrate_indicator(settings,model,obs_time)
    timestep_relative_to_obs = nudging.timestep_relative_to_obs(model,obs_time);

    min_step = min(settings.nudging.steps);
    max_step = max(settings.nudging.steps);

    if (timestep_relative_to_obs < min_step)
        next_nudging_step = min_step;
        timesteps = next_nudging_step-timestep_relative_to_obs;
    elseif (timestep_relative_to_obs >= min_step & timestep_relative_to_obs < max_step)
        next_nudging_step = min(settings.nudging.steps>timestep_relative_to_obs);
        timesteps = next_nudging_step-timestep_relative_to_obs;
    else
        warning('nudging.integrate_indicator : out of nudging period')
    end
end
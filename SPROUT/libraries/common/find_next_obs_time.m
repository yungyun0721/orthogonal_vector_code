function [fsteps, next_obs_time] = find_next_obs_time(all_observation_time,time,model)
    %% prevent truncation error
    all_observation_time = round(all_observation_time*1000);
    time = round(time*1000);
    
    %% find next time
    next_obs_time_index = find(all_observation_time>time);
    next_obs_time_index = next_obs_time_index(1);
    next_obs_time = all_observation_time(next_obs_time_index)/1000;
    
    time = time/1000;
    fsteps = round((next_obs_time-time)/model.settings.integrator.step_size);
end
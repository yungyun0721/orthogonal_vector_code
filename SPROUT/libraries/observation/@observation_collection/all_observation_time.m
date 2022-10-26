function observation_time=all_observation_time(obj)
    observation_time = [];
    for vnum = obj.observed_vars
        observation_time = [observation_time  obj.record.time{vnum}];
    end
    
    observation_time = sort(unique(observation_time));
end
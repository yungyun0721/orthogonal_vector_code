function timestep=aot_timestep(obj,analyze_time)
    vnum = length(obj.observed_vars);
    timestep = cell(1,vnum);
    multiplier = 1000;
    
    for vnum = obj.observed_vars
         timestep{vnum} = round(obj.record.time{vnum}*multiplier)==round(analyze_time*multiplier);
    end
end
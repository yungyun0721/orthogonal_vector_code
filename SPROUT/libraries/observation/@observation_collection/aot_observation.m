%% observation=aot_observation(analyze_time)
%
% get observation at specific observation time
%
% <structure>
% observation.vars      = vnum cell
% observation.available = vnum vector

%%
function observation=aot_observation(obj,analyze_time)
    %% get the index at analyze time
    timestep = obj.aot_timestep(analyze_time);
    
    %% initialization / pre-allocate
    observation.vars = cell(1,length(obj.observed_vars));
    observation.available = zeros(1,length(obj.observed_vars));
    
    %% pick up observation at analyze time
    for vnum = obj.observed_vars
        if (sum(timestep{vnum}))
            observation.available(vnum) = vnum;
            observation.vars{vnum} = obj.record.vars{vnum}(timestep{vnum},:);
        end
    end
end
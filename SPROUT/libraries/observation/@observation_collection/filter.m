%% filtered_obs_obj = observation.filter(filter_settings);
%
% this function is used to pick the observation you do (not) want to use
% the reason might is quality control, DA strategy or anything else
% 
% 
% < args >
% filter_settings.mode % 1=remove selected, 2=only remain selected
% filter_settings.vars{:}.enable = boolean
% filter_settings.vars{:}.index = [array of index]

%%
function filtered_obs_obj =  filter(obj, filter_settings)
    filtered_obs_obj = obj;
    
    for vnum = obj.observed_vars
        if filter_settings.vars{vnum}.enable
            if filter_settings.mode == 1
                remove_index = filter_settings.vars{vnum}.index;
                all_index = 1:length(obj.record.gridpoint{vnum});
                selected_index = setxor(all_index,remove_index);
            elseif filter_settings.mode == 2
                selected_index = filter_settings.vars{vnum}.index;
            end
        
            filtered_obs_obj.record.vars{vnum} = obj.record.vars{vnum}(:,selected_index);
            filtered_obs_obj.record.gridpoint{vnum} = obj.record.gridpoint{vnum}(selected_index);
            filtered_obs_obj.record.coordinate{vnum} = obj.record.coordinate{vnum}(selected_index);
            filtered_obs_obj.settings.select = filter_settings;
        end
    end
end
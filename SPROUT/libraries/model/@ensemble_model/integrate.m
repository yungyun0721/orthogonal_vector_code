%% integrate (pure version)
function obj=integrate(obj,steps)
    % initialize
    temp_ensmember = obj.ensmember;
    temp_settings = obj.settings;

    % integrate
    record = obj.settings.integrator.save_traj;
    parfor ens=1:obj.settings.ensemble.members
        for step = 1:steps
            temp_ensmember{ens} = integrator(temp_ensmember{ens},temp_settings,0,0);
            
            if record
                temp_ensmember{ens} = temp_ensmember{ens}.add_record('forecast');
            end
        end
    end

    % copy data / finalize
    obj.ensmember = temp_ensmember;
    obj.time = obj.time+steps*obj.settings.integrator.step_size;
end

% %% integrate (multiple-thread version)
% function obj=integrate(obj,steps)
%     % initialize
%     temp_ensmember = obj.ensmember;
%     temp_settings = obj.settings;
% 
%     % integrate
%     parfor ens=1:obj.settings.ensemble.members
%         temp_ensmember{ens} = integrator(temp_ensmember{ens},temp_settings,steps);
%     end
% 
%     % copy data / finalize
%     obj.ensmember = temp_ensmember;
%     obj.time = obj.time+steps*obj.settings.integrator.step_size;
% end
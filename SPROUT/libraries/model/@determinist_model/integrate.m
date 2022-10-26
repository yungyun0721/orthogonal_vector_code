%% integrate (pure version)
function obj=integrate(obj,steps)
    record = obj.settings.integrator.save_traj;
    for step = 1:steps
        obj.determinist = integrator(obj.determinist,obj.settings,0,0);

        if record
            obj.determinist = obj.determinist.add_record('forecast');
        end
    end
    
    obj.time = obj.time+steps*obj.settings.integrator.step_size;
end

% %% integrate
% function obj=integrate(obj,steps)
%     obj.determinist = integrator(obj.determinist,obj.settings,steps);
%     obj.time = obj.time+steps*obj.settings.integrator.step_size;
% end
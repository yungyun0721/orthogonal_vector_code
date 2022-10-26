%% obs_obj = observation_collection(dynamic_obj,settings);
% 
% observation_collection, a function/class will generate observation data
% input a dynamic dynamic_obj and settings
% you will get observation dynamic_object with following properties
%
% << args >>
% settings.observed_vars           = [integers];
% settings.vars{n}.perturbation    = cons;
% settings.vars{n}.space.mode      = 'interval' || 'gridpoint';
% settings.vars{n}.space.interval  = integer;
% settings.vars{n}.space.gridpoint = [integers];
% settings.vars{n}.time.mode       = 'interval' || 'timestep';
% settings.vars{n}.time.interval   = integer;
% settings.vars{n}.time.timestep   = [integers];
% 
% << observation object structure >>
% obj.observed_vars
% obj.dynamic              = [string (name of dynamic system)]
% obj.map                  = a cell contain map obj
% obj.record.vars{n}       = [float] (time*space);
% obj.record.timestep{n}   = [integers];
% obj.record.time{n}       = [float];
% obj.record.gridpoint{n}  = [integers];
% obj.record.coordinate{n} = [float];
% obj.variance{n}          = constant;
% obj.settings (backup, for developer to check their coding)

%% 
classdef observation_collection
    properties
        dynamic
        observed_vars
        settings
        map
        record
        variance
    end
    
    methods
        function obj = observation_collection(dynamic_obj,settings)
            obj.dynamic       = class(dynamic_obj);
            obj.observed_vars = settings.observed_vars;
            obj.settings      = settings;
            obj.map           = dynamic_obj.map;
            [obj.record, obj.variance] = observer(dynamic_obj,settings);
        end
    end
end
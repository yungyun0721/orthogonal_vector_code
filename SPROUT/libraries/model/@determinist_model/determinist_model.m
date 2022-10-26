classdef determinist_model
    properties
        determinist
        time
        settings
        reference
    end
    
    methods
        %% create object
        function obj=determinist_model(initial_field,settings)
            obj.determinist = feval(settings.dynamic,...
                                        initial_field.vars,settings);
            obj.time = 0;
            obj.settings = settings;
            obj.reference = obj.determinist;
        end
    end
end
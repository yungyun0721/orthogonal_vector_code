classdef ensemble_model
    properties
        ensmember
        ensmean
        time
        settings
        reference
    end
    
    methods
        %% create object
        function obj=ensemble_model(initial_field,settings)
            for ens=1:settings.ensemble.members
                obj.ensmember{ens} = feval(settings.dynamic,...
                                            initial_field{ens}.vars,settings);
            end
            obj.ensmean = obj.ensmember{1};
            obj.time = 0;
            obj.settings = settings;
            obj.reference = obj.ensmean;
            obj = obj.refresh_ensmean;
        end
    end
end
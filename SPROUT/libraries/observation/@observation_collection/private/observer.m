%% core for generate observation
function [record, variance] = observer(dynamic_obj,settings)
    %% initialize observation
    record.vars      = cell(size(dynamic_obj.varname));
    record.timestep  = cell(size(dynamic_obj.varname));
    record.time      = cell(size(dynamic_obj.varname));
    record.gridpoint = cell(size(dynamic_obj.varname));
    record.space     = cell(size(dynamic_obj.varname));
    variance         = cell(size(dynamic_obj.varname));
    
    for vnum = settings.observed_vars
        %% space
        % get the gridpoint to pick up observation
        switch settings.vars{vnum}.space.mode
            case 'interval'
                if (mod(dynamic_obj.map{vnum}.grid_points,settings.vars{vnum}.space.interval) ~= 0)
                    warning('observation : grid_points is not a multiple of interval.')
                end
                record.gridpoint{vnum} = 1:settings.vars{vnum}.space.interval:dynamic_obj.map{vnum}.grid_points;
            case 'gridpoint'
                record.gridpoint{vnum} = settings.vars{vnum}.space.gridpoint;
            otherwise
                error('observation : no corresponding space.mode')
        end
        % record the corresponding space
        record.coordinate{vnum} = dynamic_obj.map{vnum}.coordinate(record.gridpoint{vnum});
        
        %% time
        % get the timestep to pick up observation
        switch settings.vars{vnum}.time.mode
            case 'interval'
                record.timestep{vnum} = 1+settings.vars{vnum}.time.interval:...
                                            settings.vars{vnum}.time.interval:dynamic_obj.record.num;
            case 'timestep'
                record.timestep{vnum} = settings.vars{vnum}.time.timestep;
            otherwise
                error('observation : no corresponding time.mode')
        end
        % record the corresponding time
        record.time{vnum} = dynamic_obj.record.time(record.timestep{vnum});
    end
    
    %% perturb and pick-up obj in appointed space, time
    full_obervation = dynamic_obj.record.vars;
	record.vars{vnum} = cell(1,length(dynamic_obj.varname));
	for vnum = settings.observed_vars
        % control the random number generator
        if settings.vars{vnum}.rng.enable
            rng(settings.vars{vnum}.rng.seeds)
        else
            rng('default')
        end
        
        % R, observation error variance
        variance{vnum} = (settings.vars{vnum}.perturbation)^2;
        
        % pick up truth at specified time and space
        record.vars{vnum} = full_obervation{vnum}(record.timestep{vnum},record.gridpoint{vnum});
        
        % get random number
        random = randn(size(record.vars{vnum}'))';
        if settings.vars{vnum}.unbias
            bias = mean(random,2);
            random = bsxfun(@minus,random,bias);
        end
        if settings.vars{vnum}.resize
            vlength = length(random(1,:));
            resize_factor = std(random,0,2)*sqrt((vlength-1)/vlength);
            random = bsxfun(@rdivide,random,resize_factor);
        end
        
        % add perturbation
        perturbation.vars{vnum} = settings.vars{vnum}.perturbation*random;
        record.vars{vnum} = record.vars{vnum}+perturbation.vars{vnum};
	end
end
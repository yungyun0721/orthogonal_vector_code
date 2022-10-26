%% obj = gathered_integrate(obj,steps)
%
% by gather ensemble_model obj into a determinist-model-like gathered_ens_model
% it avoid the loop for ensembles, make integration more efficient 
% and prevent wasting time to tranfer data between process
% of course, it does NOT rely on parallel computing
%
% gathered_integrate will use 1st ensemble member as base of gathered_ens_model
% for ensemble_model with different parameter settings, DO NO use gathered_integrate
%
function obj = gathered_integrate(obj,steps)
    record = obj.settings.integrator.save_traj;
    
    if record
        for step = 1:steps
            gathered_ens_model = gatherer(obj);
            gathered_ens_model = integrator(gathered_ens_model,obj.settings,0,0);
            
            obj = divider(obj,gathered_ens_model);
            obj = obj.add_record('forecast');
        end
    else
        gathered_ens_model = gatherer(obj);
        for step = 1:steps
            gathered_ens_model = integrator(gathered_ens_model,obj.settings,0,0);
        end
        obj = divider(obj,gathered_ens_model);
    end
end

%% gathered_ens_model = gatherer(obj)
%
% gather ensemble_model obj into a determinist-model-like gathered_ens_model
%
function gathered_ens_model = gatherer(obj)
    gathered_ens_model = obj.ensmember{1};
    ens_vars = cellfun(@(x) x.vars,obj.ensmember,'UniformOutput', false);
    varlength = length(ens_vars{1});
    for vnum = 1:varlength
        temp = cellfun(@(x) x{vnum}, ens_vars, 'UniformOutput', false);
        gathered_ens_model.vars{vnum} = cat(1,temp{:});
    end
end

%% obj = divider(obj,gathered_ens_model,steps)
% 
% divide the gathered_ens_model into original ensemble_model obj
%
function obj = divider(obj,gathered_ens_model)
    varlength = length(obj.ensmean.vars);
    for ens=1:obj.settings.ensemble.members
        for vnum = 1:varlength
            obj.ensmember{ens}.vars{vnum} = gathered_ens_model.vars{vnum}(ens,:);
        end
        obj.ensmember{ens}.time = gathered_ens_model.time;
    end
    obj.time = gathered_ens_model.time;
end
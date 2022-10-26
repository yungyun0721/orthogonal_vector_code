%% ensemble_obj = ensemble_obj.revert_by_model(model)
%
% revert the model state to the record state 
%

%%
function obj = revert_by_model(obj,model)
    for ens = 1:length(obj.ensmember)
        obj.ensmember{ens}.vars = model.ensmember{ens}.vars;
        obj.ensmember{ens}.time = model.ensmember{ens}.time;
    end
    obj.time = model.time;
end
%% determinist_obj = determinist_obj.revert_by_model(model)
%
% revert the model state to the record state 
%

%%
function obj = revert_by_model(obj,model)
    obj.determinist.vars{vnum} = model.determinist.vars;
    obj.determinist.time = model.determinist.time;
    obj.time = model.time;
end
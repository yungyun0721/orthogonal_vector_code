%% determinist_obj = determinist_obj.revert_by_record(record_num)
%
% revert the model state to the record state 
%

%%
function obj = revert_by_record(obj,record_num)
    vlength = length(obj.reference.vars);
    time = obj.determinist.record.time(record_num);

    for vnum = 1:vlength
        obj.determinist.vars{vnum} = obj.determinist.record.vars{vnum}(record_num,:);
    end
    obj.determinist.time = time;
    obj.time = time;
end
%% ensemble_obj = ensemble_obj.revert_by_record(record_num)
%
% revert the model state to the record state 
%

%%
function obj = revert_by_record(obj,record_num)
    vlength = length(obj.reference.vars);
    time = obj.ensmember{1}.record.time(record_num);
    
    for ens = 1:length(obj.ensmember)
        for vnum = 1:vlength
            obj.ensmember{ens}.vars{vnum} = obj.ensmember{ens}.record.vars{vnum}(record_num,:);
        end
        obj.ensmember{ens}.time = time;
    end
    obj.time = time;
end
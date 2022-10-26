%% refresh ensemble mean state

%% cellfun+cat version : avoid truncation error but use more memory and time for computation 
function obj=refresh_ensmean(obj)
    %% refreash mean
    vars_temp = cellfun(@(x) x.vars,obj.ensmember,'UniformOutput', 0);
    vars_temp = vertcat(vars_temp{:});
    record_vars_temp = cellfun(@(x) x.record.vars,obj.ensmember,'UniformOutput', 0);
    record_vars_temp = cat(1,record_vars_temp{:});
    
    for vnum=1:length(obj.ensmean.varname)
        obj.ensmean.vars{vnum} = mean(vertcat(vars_temp{:,vnum}));
        obj.ensmean.record.vars{vnum} = mean(cat(3,record_vars_temp{:,vnum}),3);
    end
    
    %% refreash time/num
    obj.ensmean.record.time = obj.ensmember{1}.record.time;
    obj.ensmean.record.num  = obj.ensmember{1}.record.num;
    obj.ensmean.record.note = obj.ensmember{1}.record.note;
    obj.ensmean.time = obj.ensmember{1}.time;
end

%% loop+add_increment version : faster but com with more truncation error
% function obj=refresh_ensmean(obj)
%     %% initial
%     for vnum=1:length(obj.ensmean.varname)
%         obj.ensmean.vars{vnum} = zeros(size(obj.ensmember{1}.vars{vnum}));
%         obj.ensmean.record.vars{vnum} = zeros(size(obj.ensmember{1}.record.vars{vnum}));
%     end
%     
%     %% sum
%     for ens=1:obj.settings.ensemble.members
%         for vnum=1:length(obj.ensmean.varname)
%             obj.ensmean.record.vars{vnum} = ...
%                 obj.ensmean.record.vars{vnum}+obj.ensmember{ens}.record.vars{vnum};
%         end
%         obj.ensmean = obj.ensmean.add_increment(obj.ensmember{ens},1,false);
%     end
%     
%     %% refreash mean
%     for vnum=1:length(obj.ensmean.varname)
%         obj.ensmean.record.vars{vnum} = obj.ensmean.record.vars{vnum}/obj.settings.ensemble.members;
%         obj.ensmean.vars{vnum} = obj.ensmean.vars{vnum}/obj.settings.ensemble.members;
%     end
%     
%     %% refreash time/num
%     obj.ensmean.record.time = obj.ensmember{1}.record.time;
%     obj.ensmean.record.num = obj.ensmember{1}.record.num;
%     obj.ensmean.time = obj.ensmember{1}.time;
% end
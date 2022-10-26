function newobj=select_refresh_ensmean(newobj,selectEns)
    %% refreash mean
    vars_temp = cellfun(@(x) x.vars,newobj.ensmember,'UniformOutput', 0);
    vars_temp = vars_temp(selectEns);
    vars_temp = vertcat(vars_temp{:});
    record_vars_temp = cellfun(@(x) x.record.vars,newobj.ensmember,'UniformOutput', 0);
    record_vars_temp = record_vars_temp(selectEns);
    record_vars_temp = cat(1,record_vars_temp{:});
    
    for vnum=1:length(newobj.ensmean.varname)
        newobj.ensmean.vars{vnum} = mean(vertcat(vars_temp{:,vnum}));
        newobj.ensmean.record.vars{vnum} = mean(cat(3,record_vars_temp{:,vnum}),3);
    end
    
    %% refreash time/num
    newobj.ensmean.record.time = newobj.ensmember{1}.record.time;
    newobj.ensmean.record.num  = newobj.ensmember{1}.record.num;
    newobj.ensmean.record.note = newobj.ensmember{1}.record.note;
    newobj.ensmean.time = newobj.ensmember{1}.time;
end
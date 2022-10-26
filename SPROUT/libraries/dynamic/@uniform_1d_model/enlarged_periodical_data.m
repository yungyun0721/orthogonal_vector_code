function value=enlarged_periodical_data(obj,var_num)
    value = [obj.record.vars{var_num}(:,end),obj.record.vars{var_num},obj.record.vars{var_num}(:,1)];
end
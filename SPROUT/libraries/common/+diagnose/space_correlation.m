function output = space_correlation(determinist,slcvnum,slcvindex)
    %% initialize
    total_length = determinist.record.num;
    vlength = length(determinist.record.vars);
    data = cell(1,vlength);
    output.vars = cell(1,vlength);
    for vnum = 1:vlength
        data{vnum} = determinist.record.vars{vnum}(1:total_length,:);
        output.vars{vnum} = null([1 length(data{vnum}(1,:))]);
    end
    
    %% calculate auto-correlation
    selected_variable = data{slcvnum}(:,slcvindex);
    
    for vnum = 1:vlength
        for vindex = 1:length(data{vnum}(1,:))
            other_variable = data{vnum}(:,vindex);
            output.vars{vnum}(vindex) = corr(selected_variable,other_variable);
        end
    end
end
function obj=erase_record(obj,startindex,endindex)
    %% convert logical to integer index
    if (islogical(startindex))
        startindex = find(startindex);
    end
    if (islogical(endindex))
        endindex = find(endindex);
    end
    
    %% error check
    if startindex<=0
        warning('erase_record : startindex<=0')
        return
    elseif isempty(startindex)
        warning('erase_record : startindex is empty')
        return
    elseif endindex<=0
        warning('erase_record : endindex<=0')
        return
    elseif isempty(endindex)
        warning('erase_record : endindex is empty')
        return
    end

    %% erase record
    obj.record.time(startindex:endindex) = 0;
	for vnum=1:length(obj.varname)
        obj.record.vars{vnum}(startindex:endindex,:) = 0;
	end
	obj.record.num = startindex-1;
end
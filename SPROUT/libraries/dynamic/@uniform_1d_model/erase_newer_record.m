function obj = erase_newer_record(obj,start_time)
    all_record_time = obj.record.time;
    newer_index = find(round(all_record_time*1000) >= round(start_time*1000));
    
    if ~isempty(newer_index)
        startindex = newer_index(1);
        endindex   = newer_index(end);
    else
        warning('erase_newer_record : no newer record')
        return
    end
    
    obj = obj.erase_record(startindex,endindex);
end
function obj = erase_newer_record(obj,start_time)
    for ens = 1:obj.settings.ensemble.members
        obj.ensmember{ens} = obj.ensmember{ens}.erase_newer_record(start_time);
    end
end
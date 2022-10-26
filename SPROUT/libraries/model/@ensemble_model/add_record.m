function obj = add_record(obj,note)
    if ~exist('note','var')
        note = '';
    end

    for ens = 1:obj.settings.ensemble.members
        obj.ensmember{ens} = obj.ensmember{ens}.add_record(note);
    end
end
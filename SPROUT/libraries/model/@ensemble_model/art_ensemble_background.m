%% background = model.art_ensemble_background(record_time,note_type);
%
% pick-up the ensemble background from record at specified record num
%
% input
% record_time : the time you want (corresponding to record.time, but not index)
% note_type   : the note you want (corresponding to record.note)
%
% output
% background{ens}.vars{vnum}

%%
function background = art_ensemble_background(obj,record_time,note_type)
    %% initialization
    background = cell(1,obj.settings.ensemble.members);
    for ens=1:obj.settings.ensemble.members
        background{ens}.vars = cell(size(obj.ensmember{ens}.vars));
    end
    
    %% pick-up background at specified time
    if (exist('note_type','var') && ~isempty(note_type))
        timestep = obj.art_timestep(record_time,note_type);
    else
        timestep = obj.art_timestep(record_time);
    end

    if (length(timestep) ~= 1)
        warning(['art_ensemble_background : ',num2str(length(timestep)),' matched record, check your criterion'])
    end

	for ens=1:obj.settings.ensemble.members
        for vnum=1:length(obj.ensmean.varname)
            background{ens}.vars{vnum} = obj.ensmember{ens}.record.vars{vnum}(timestep,:);
        end
	end
end
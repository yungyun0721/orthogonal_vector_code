%% background = model.art_background(record_time,note_type);
%
% pick-up the ensemble background from record at specified record num
%
% input
% record_time : the time you want (corresponding to record.time, but not index)
% note_type   : the note you want (corresponding to record.note)
%
% output
% background.vars{vnum}

%%
function background = art_background(obj,record_time,note_type)
    %% initialization
    obj = obj.refresh_ensmean;
    background.vars = cell(size(obj.ensmean.vars));
    
    %% pick-up background at specified time
    if (exist('note_type','var') && ~isempty(note_type))
        timestep = obj.art_timestep(record_time,note_type);
    else 
        timestep = obj.art_timestep(record_time);
    end

    if (length(timestep) ~= 1)
        warning(['art_background : ',num2str(length(timestep)),' matched record, check your criterion'])
    end

    for vnum=1:length(obj.ensmean.varname)
        background.vars{vnum} = obj.ensmean.record.vars{vnum}(timestep,:);
    end
end
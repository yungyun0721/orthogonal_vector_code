%% [record_num, note] = model.art_timestep(record_time,note_type);
%
% sort record by time and note
%
% << input >>
% time      : the time you want (corresponding to record.time, but not index)
% note_type : the note you want (corresponding to record.note)
%
% << output >>
% record_num
% note

%%
function [timestep, note] = art_timestep(obj,record_time,note_type)
    multiplier = 1000;
    timestep = find(round(obj.determinist.record.time*multiplier)==round(record_time*multiplier));
    note = obj.determinist.record.note(timestep);

    if (exist('note_type','var') && ~isempty(note_type))
        timestep = timestep(strcmp(note,note_type));
        note = note(timestep);
    end
end
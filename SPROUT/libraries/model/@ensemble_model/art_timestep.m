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
function [record_num, note] = art_timestep(obj,record_time,note_type)
    multiplier = 1000;
    record_num = find(round(obj.ensmember{1}.record.time*multiplier)==round(record_time*multiplier));
    note = obj.ensmember{1}.record.note(record_num);
    
    if (exist('note_type','var') && ~isempty(note_type))
        record_num = record_num(strcmp(note,note_type));
        note = obj.ensmember{1}.record.note(record_num);
    end
end
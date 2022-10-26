%% index = record.category_by_note(record)

%%
function index = category_by_note(record)
    note = record.note(1:record.num);
    all_note_types = unique(note);
    for note_type = all_note_types
        if ~isempty(note_type{1})
            note_type_name = note_type{1};
            trim_note_type_name = strtrim(note_type{1});
        else
            note_type_name = 'isempty';
        end
        
        index.(trim_note_type_name) = find(strcmp(note,note_type_name));
    end
end
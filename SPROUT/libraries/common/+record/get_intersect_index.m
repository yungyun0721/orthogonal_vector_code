%% [truth_index, model_index] = get_intersect_index(truth_time,model_time);

%%
function [truth_index, model_index] = get_intersect_index(truth_time,model_time)
    truth_index = [];
    model_index = [];
    for model_time_index = 1:length(model_time)
        temp_index = find(model_time(model_time_index) == truth_time);
        if ~isempty(temp_index)
            truth_index = [truth_index; temp_index];
            model_index = [model_index; model_time_index];
        end
    end
end
%% rmse = all_time_rmse(truth,model);
%
% calculate root-mean-square-error during all the intersection time
% for observation, only partial support for all variable observed at same time
%
% <output>
% rmse.source_type
% rmse.vars{vnum}
% rmse.time
% rmse.note

%%
function rmse=all_time_rmse(truth,model)
    %% pick-up
    switch  class(model)
        case 'determinist_model'
            model_vars = model.determinist.record.vars;
            model_time = model.determinist.record.time;
            rmse.source_type = 'determinist_model';
            rmse.note = model.determinist.record.note;
        case 'ensemble_model'
            model_vars = model.ensmean.record.vars;
            model_time = model.ensmean.record.time;
            rmse.source_type = 'ensemble_model';
            rmse.note = model.ensmean.record.note;
        case 'observation_collection'
            model_vars = model.record.vars;
            model_time = model.record.time{1};
            rmse.source_type = 'observation_collection';
    end
    truth_vars = truth.determinist.record.vars;
    truth_time = truth.determinist.record.time;

    %% select the period
    truth_time = round(truth_time*1000);
    model_time = round(model_time*1000);
    
    [truth_index, model_index] = record.get_intersect_index(truth_time,model_time);

    %% calculate root mean square error
    rmse.vars = cell(1,length(truth_vars));
    for vnum=1:length(truth_vars)
        err = model_vars{vnum}(model_index,:)-truth_vars{vnum}(truth_index,:);
        rmse.vars{vnum} = sqrt(mean(err.^2,2));
    end
    rmse.time = truth.determinist.record.time(truth_index);
end
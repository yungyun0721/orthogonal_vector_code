%% es = all_time_es(model);
%
% calculate ensemble spread for ensemble_model
%
% <output>
% es.vars{vnum}
% es.rmse.vars{vnum}
% es.time

%%
function es=all_time_es(model)
    %% calculate ensemble spread
    K = length(model.ensmember);
    record_length = model.ensmean.record.num;
    
    es.vars = cell(1,length(model.ensmean.record.vars));
    es.rmse.vars = cell(1,length(model.ensmean.record.vars));
    for vnum=1:length(model.ensmean.record.vars)
        vlength = length(model.ensmean.record.vars{vnum}(1,:));
        ensemble = zeros(K,record_length,vlength);
        ensemble_mean = zeros(1,record_length,vlength);
        ensemble_mean(1,:,:) = model.ensmean.record.vars{vnum}(1:record_length,:);
        for ens=1:K
            ensemble(ens,:,:) = model.ensmember{ens}.record.vars{vnum}(1:record_length,:);
        end
        
        ensemble_perturbation = bsxfun(@minus,ensemble,ensemble_mean);
        
        es.vars{vnum} = squeeze(sqrt(sum(ensemble_perturbation.^2)/(K-1)));
        
        error = es.vars{vnum};
        es.rmse.vars{vnum} = sqrt(mean(error.^2,2));
        es.mean.vars{vnum} = mean(error,2);
    end
    es.time = model.ensmean.record.time(1:record_length);
end
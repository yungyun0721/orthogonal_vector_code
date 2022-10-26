function obj=update_ensemble(obj,ensemble_analysis)
    %% check analysis
    if (~isa(ensemble_analysis,'ensemble_analysis'))
        error('ensemble_model/update_ensemble : wrong ensemble_analysis')
    end
    
    % vars_to_update
    update_vars = ensemble_analysis.settings.model_vars;

    %% vars/time
    obj.time = ensemble_analysis.analyze_time;
    
    %% inner ensemble
    for ens=1:obj.settings.ensemble.members;
        %% vars/time
        obj.ensmember{ens}.time = ensemble_analysis.analyze_time;
        obj.ensmember{ens}.vars(update_vars) = ensemble_analysis.ensmember{ens}.vars(update_vars);
    end
end
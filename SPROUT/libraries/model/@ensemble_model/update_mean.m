function obj=update_mean(obj,determinist_analysis)
    %% check analysis
    if (~isa(determinist_analysis,'determinist_analysis'))
        error('ensemble_model.update_mean : wrong determinist_analysis')
    end

    % vars_to_update
    update_vars = determinist_analysis.settings.model_vars;
    
    if round(obj.time*1000) == round(determinist_analysis.analyze_time*1000)
        obj = obj.refresh_ensmean;
        increment = get_increment(obj.ensmean,determinist_analysis.determinist);
        ensemble_background = obj.ensmember;
    else
        warning('ensemble_model.update_mean : no current vars, use record')
        obj.time = determinist_analysis.analyze_time;
        increment = get_increment(obj.art_background(determinist_analysis.analyze_time),determinist_analysis.determinist);
        ensemble_background = obj.art_ensemble_background(determinist_analysis.analyze_time);
    end
    
    for ens=1:obj.settings.ensemble.members;
        %% vars/time recover to analyze time
        obj.ensmember{ens}.time = determinist_analysis.analyze_time;
        obj.ensmember{ens}.vars(update_vars) = ensemble_background{ens}.vars(update_vars);

        %% add increment
        obj.ensmember{ens} = obj.ensmember{ens}.add_increment(increment, 1, false);
    end
end
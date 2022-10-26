function obj=update(obj,determinist_analysis)
    %% check analysis
    if (~isa(determinist_analysis,'determinist_analysis'))
        error('determinist_model/update : wrong determinist_analysis')
    end

    % vars_to_update
    update_vars = determinist_analysis.settings.model_vars;
    
    %% vars/time
    obj.time = determinist_analysis.analyze_time;
    obj.determinist.time = determinist_analysis.analyze_time;
    obj.determinist.vars(update_vars) = determinist_analysis.determinist.vars(update_vars);
end
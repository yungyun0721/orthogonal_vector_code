%% material = iau.preinitializer(model,pre_analysis,settings);
%
% <settings>
% settings.iau.weighting
%
% <output>
% material.iau.analysis_type
% material.iau.increment
% material.iau.passed_step

%%
function material = preinitializer(model,pre_analysis,settings)
    %% prepare weighting matrix
    weighting_matrix.vars = cell(1,length(model.reference.vars));
    if isrow(settings.iau.weighting)
        settings.iau.weighting = (settings.iau.weighting)';
    end
    for vnum = 1:length(model.reference.vars)
        mlength = length(model.reference.vars{vnum});
        weighting_matrix.vars{vnum} = repmat(settings.iau.weighting,[1, mlength]);
    end

    %% calculate increment
    if (isa(pre_analysis,'determinist_analysis'))
        material.iau.analysis_type = 'determinist_analysis';
        material.iau.increment = calculate_increment(model.determinist,pre_analysis.determinist,weighting_matrix,settings);
    elseif (isa(pre_analysis,'ensemble_analysis'))
        material.iau.analysis_type = 'ensemble_analysis';
        material.iau.increment = cell(1,model.settings.ensemble.members);
        for ens = 1:model.settings.ensemble.members
            material.iau.increment{ens} = calculate_increment(model.ensmember{ens},pre_analysis.ensmember{ens},weighting_matrix,settings);
        end
    else
        error('iau.preinitializer : pre_analysis is not standard analysis')
    end
    material.iau.passed_step = 0;
end

function increment = calculate_increment(det_dynamic,det_analysis,weighting_matrix,settings)
    % get total_increment
    total_increment = get_increment(det_dynamic,det_analysis);

    % calculate IAU increment
    increment.vars = cell(1,length(det_dynamic.vars));
    for vnum = 1:length(det_dynamic.vars)
        total_increment_matrix = repmat(total_increment.vars{vnum},[length(settings.iau.weighting), 1]);
        increment.vars{vnum} = total_increment_matrix.*weighting_matrix.vars{vnum};
    end
end
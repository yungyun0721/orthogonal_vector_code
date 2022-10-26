%% [analysis, addition, material] = iau.main(model,material);
%


%%
function [analysis, addition, material] = main(model,material)
    %% pre-perform Ensemble Transform Kalman Filter
    now_step      = material.iau.passed_step+1;
    increment     = material.iau.increment;
    analysis_type = material.iau.analysis_type;

    %% plus increment
    if strcmp(analysis_type,'determinist_analysis')
        for vnum = 1:length(model.reference.vars)
            analysis.vars{vnum} = model.determinist.vars{vnum}+increment.vars{vnum}(now_step,:);
        end
    elseif strcmp(analysis_type,'ensemble_analysis')
        analysis = cell(1,model.settings.ensemble.members);
        for ens = 1:model.settings.ensemble.members
            analysis{ens}.vars = model.ensmember{ens}.vars;
            for vnum = 1:length(model.reference.vars)
                analysis{ens}.vars{vnum} = analysis{ens}.vars{vnum}+increment{ens}.vars{vnum}(now_step,:);
            end
        end
    end 

    %% material
    material.iau.passed_step = now_step;
    addition = false;
end
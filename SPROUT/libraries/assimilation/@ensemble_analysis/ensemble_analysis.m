%% analysis = ensemble_analysis(model,obs_collection,settings,obs_time,material);
%
% Based on ensemble model and DA scheme,
% use the current model state as background (initial guess)
% and the observation find in the specific time
% to estimate what the truth state is.
%
% <properties>
% ensmember (analysis)
% bg_ensmember
% reference
% settings
% obs_time
% analyze_time
% addition
% material
% 
% <methods>
% obj.ensmean
% obj.bg_ensmean

%%
classdef ensemble_analysis
    properties
        ensmember  % analysis
        bg_ensmember
        reference
        settings
        obs_time
        analyze_time
        addition
        material
    end
    
    methods
        function obj = ensemble_analysis(model,obs_collection,settings,obs_time,material)
            obj.bg_ensmember = model.ensmember;
            obj.reference    = model.reference;
            obj.settings     = settings;
            obj.obs_time     = obs_time;
            obj.analyze_time = model.time;

            if (~exist('material','var'))
                material = false;
            end

            [obj.ensmember, obj.addition, obj.material] = ...
                        analyzer(model,obs_collection,settings,obs_time,material);
        end

        function output = ensmean(obj)
            output = ensmean_core(obj.ensmember);
        end
        function output = bg_ensmean(obj)
            output = ensmean_core(obj.bg_ensmember);
        end
    end
end

function [analysis, addition, material] = analyzer(model,obs_collection,settings,obs_time,material)
    %% calculate the analysis field
    switch settings.analyze_method
%         case 'En4DVar'
%             analysis = en_four_dvar(model,obs_collection,settings,obs_time);
%         case 'EnKF'
%             [analysis, addition] = da.enkf(model,obs_collection,settings,obs_time);
        case 'IAU'
            if ~strcmp(material.iau.analysis_type,'ensemble_analysis')
                error('ensemble_analysis/analyzer/iau : wrong analysis type')
            end
            [analysis, addition, material] = iau.main(model,material);
        case 'ETKF'
            [analysis, addition]           = etkf.main(model,obs_collection,settings,obs_time);
        case 'LETKF'
            [analysis, addition]           = letkf.main(model,obs_collection,settings,obs_time,material);
        case 'ETKS'
            [analysis, addition]           = etks.main(model,settings,material);
        case 'LETKS'
            [analysis, addition]           = letks.main(model,settings,material);
        case 'ETKIS'
            [analysis, addition, material] = etkis.main(model,settings,material);
        case 'LETKIS'
            [analysis, addition, material] = letkis.main(model,settings,material);
        otherwise
            error('da : no corresponding analyze method');
    end
end

function output = ensmean_core(ensmember)
    %% refreash mean
    vars_temp = cellfun(@(x) x.vars,ensmember,'UniformOutput', 0);
    vars_temp = vertcat(vars_temp{:});
    
    for vnum=1:length(ensmember{1}.vars)
        output.vars{vnum} = mean(vertcat(vars_temp{:,vnum}));
    end
end
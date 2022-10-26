%% analysis = determinist_analysis(model,obs_collection,settings,obs_time,material);
%
% Based on determinist model and DA scheme,
% use the current model state as background (initial guess)
% and the observation find in the specific time
% to estimate what the truth state is.
%
% <properties>
% determinist (analysis)
% bg_determinist
% reference
% settings
% obs_time
% analyze_time
% addition
% material

%%
classdef determinist_analysis
    properties
        determinist  % analysis
        bg_determinist
        reference
        settings
        obs_time
        analyze_time
        addition
        material
    end
    
    methods
        function obj=determinist_analysis(model,obs_collection,settings,obs_time,material)
            if isa(model,'determinist_model')
                obj.bg_determinist = model.determinist;
            elseif isa(model,'ensemble_model')
                obj.bg_determinist = model.ensmean;
            end
            obj.reference      = model.reference;
            obj.settings       = settings;
            obj.obs_time       = obs_time;
            obj.analyze_time   = model.time;

            if (~exist('material','var'))
                material = false;
            end
            [obj.determinist, obj.addition, obj.material] = ...
                                        analyzer(model,obs_collection,settings,obs_time,material);
        end
    end
end

function [analysis, addition, material]=analyzer(model,obs_collection,settings,obs_time,material)
    global truth
    %% calculate the analysis field
    switch settings.analyze_method
        case 'Truth'
            analysis = truth.determinist;
            addition = false;
        case 'IAU'
            if ~strcmp(material.iau.analysis_type,'determinist_analysis')
                error('determinist_analysis/analyzer/iau : wrong analysis type')
            end
            [analysis, addition, material] = iau.main(model,material);
        case 'Nudging'
            [analysis, addition] = nudging.main(model,obs_collection,settings,obs_time);
%         case 'Obs'
%             analysis = combine_directly(model,obs_collection,obs_time);
%         case '3DVar'
%             analysis = three_dvar(model,obs_collection,settings,obs_time);
%         case '4DVar'
%             analysis = four_dvar(model,obs_collection,settings,obs_time);
        otherwise
            error('da : no corresponding analyze method');
    end
end
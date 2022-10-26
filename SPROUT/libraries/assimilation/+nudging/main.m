%% [analysis, addition] = nudging.main(model,obs_collection,settings,obs_time);
% 
% 
% 
% 

%%
function [analysis, addition] = main(model,obs_collection,settings,obs_time)
    %% get basic element
    msv = model.dmsv(settings.analyze_vars);
    osv = obs_collection.osv(settings.analyze_vars,obs_time,model,msv);

    %% calculate weighting
    timestep_relative_to_obs = nudging.timestep_relative_to_obs(model,obs_time);
    weighting = nudging.confidence_weigher(settings,model,obs_collection,timestep_relative_to_obs);
    
    %% calculate increment
    increment = weighting*osv.innovation;

    %% analysis
    xa = msv.xb+increment;
    analysis = da.fold_background(xa,msv.background,msv.mss,settings.model_vars);

    %% package
    addition.weighting = weighting;
end
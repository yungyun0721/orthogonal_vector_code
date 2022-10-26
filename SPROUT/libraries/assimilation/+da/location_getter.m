%% location = da.location_getter(model,obs_collection);
%
% get location data
%
% <output>
% location.model.dim
% location.model.coordinate
% location.obs.dim
% location.obs.coordinate

%%
function location = location_getter(settings,model,obs_collection)
    model_coordinate.vars = cell(1,length(model.reference.varname));
    for dim=1:length(model.reference.varname)
        model_coordinate.vars{dim} = model.reference.map{dim}.coordinate;
    end
    obs_coordinate.vars = obs_collection.record.coordinate;

    % coordinate
    location.model.coordinate = cell2mat(model_coordinate.vars(settings.analyze_vars));
    location.obs.coordinate = cell2mat(obs_coordinate.vars(settings.observation_vars));
    
    % dim
    mss = space_size_counter(model_coordinate,settings.analyze_vars);
    oss = space_size_counter(obs_coordinate,settings.observation_vars);
    
    model_dim_length = cell(1,length(model.reference.varname));
    obs_dim_length = cell(1,length(model.reference.varname));
    for dim=1:length(model.reference.varname)
        model_dim_length{dim} = ones(1,mss(dim))*dim;
        obs_dim_length{dim} = ones(1,oss(dim))*dim;
    end
    location.model.dim = cell2mat(model_dim_length);
    location.obs.dim = cell2mat(obs_dim_length);
end
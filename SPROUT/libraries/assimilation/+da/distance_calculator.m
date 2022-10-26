%% [dist, real_distance, dim_distance] = da.distance_calculator(settings,model,obs_collection)
%
% get distance between location.model and location.obs
%
% <output>
% dist = matrix(olength,xlength)
% real_distance
% dim_distance

%%
function [dist, real_distance, dim_distance] = distance_calculator(settings,model,obs_collection)
    location = da.location_getter(settings,model,obs_collection);

    % real distance
    [xlocation, olocation] = meshgrid(location.model.coordinate,location.obs.coordinate);
    real_distance = abs(xlocation-olocation);
    
    % unfold for periodical boundary
    if model.reference.periodical
        domain_size = model.reference.map{1}.domain_size;
        index_to_fold = real_distance>domain_size/2;
        real_distance(index_to_fold) = domain_size-real_distance(index_to_fold);
    end
    
    % extra dim distance
    [plus_map, multi_map] = dim_distance_info(settings,location);
    dim_distance = real_distance.*(multi_map-1)+plus_map;
    
    % combine
    dist = max(real_distance+dim_distance,0);
end

%%
function [plus_map, multi_map] = dim_distance_info(settings,location)
    [xdims, odims] = meshgrid(location.model.dim,location.obs.dim);
    plus_map = zeros(size(xdims));
    multi_map = ones(size(xdims));
    
    for xdim=1:length(settings.dc.dim_distance_plus)
        for odim=1:length(settings.dc.dim_distance_plus)
            corresponding_index = (xdims==xdim & odims==odim);
            plus_map(corresponding_index) = settings.dc.dim_distance_plus(odim,xdim);
            multi_map(corresponding_index) = settings.dc.dim_distance_multi(odim,xdim);
        end
    end
end
%% material = letkf.preinitializer(settings,model,obs_collection);
%
% part of Local Ensemble Transform Kalman Filter
%
% <output>
% material.letkf.y_local_index
% material.letkf.dist
% material.letkf.location
% material.letkf.locR
% material.letkf.obs_available

%%
function material = preinitializer(settings,model,obs_collection)
    location = da.location_getter(settings,model,obs_collection);
    dist = da.distance_calculator(settings,model,obs_collection);
    xlength = length(location.model.coordinate);
    
    oss = ideal_oss(settings,obs_collection);
    R = da.build_obs_variance(obs_collection,oss);
    
    %% select observation
    y_local_index = cell(1,xlength);
    locR = cell(1,xlength);
    for xindex = 1:xlength
        xdim = location.model.dim(xindex);
        distance = dist(:,xindex);
        
        y_local_index{xindex} = distance<=settings.letkf.truncation_distance(xdim);
        locR{xindex} = R(y_local_index{xindex},y_local_index{xindex});
    end

    %% obs_available
    obs_available = zeros(1,length(y_local_index));
    for xindex = 1:length(y_local_index)
        obs_available(xindex) = (~isempty(y_local_index{xindex}) && sum(y_local_index{xindex})~=0);
    end
    obs_available = find(obs_available);
    
    %% R localization
    for xindex = 1:xlength
        if settings.letkf.rlocalization.enable
            loc.dist = dist(y_local_index{xindex},xindex);
            loc.R = locR{xindex};
            xdim = location.model.dim(xindex);
            locR{xindex} = letkf.r_localization(settings,xdim,loc);
        end
    end
    
    %% package
    material.letkf.y_local_index = y_local_index;
    material.letkf.dist = dist;
    material.letkf.location = location;
    material.letkf.locR = locR;
    material.letkf.obs_available = obs_available;
end

function oss=ideal_oss(settings,obs_collection)
    oss = zeros(1,length(obs_collection.record.vars));
    for vnum = settings.observation_vars
        oss(vnum) = length(obs_collection.record.vars{vnum}(1,:));
    end
end
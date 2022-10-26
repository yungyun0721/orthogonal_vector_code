function weighting = confidence_weigher(settings,model,obs_collection,timestep_relative_to_obs)
    % get current_max_weighting
    settings_index = find(settings.nudging.steps == timestep_relative_to_obs);
    if isempty(settings_index)
        error('nudging.confidence_weighting : not in nudging period')
    end
    current_max_weighting = settings.nudging.weighting(settings_index);

    % get distance
    dist = da.distance_calculator(settings,model,obs_collection);
    dist = dist';

    % calculate confidence decay by distance
    decay = @(distance) exp(-(distance.^2)/(2*(settings.nudging.radius)^2));
    confidence = decay(dist);

    % calculate total_confidence and best_combination
    weighting = zeros(size(dist));
    variance = confidence.^(-1);
    for xindex = 1:size(dist,1)
        weighting(xindex,:) = da.blue(variance(xindex,:));
    end
    
    % total confidence resize
    total_confidence = sum(confidence,1);
    total_confidence_resize = min(total_confidence,1);

    % resize by confidence
    weighting = bsxfun(@times,weighting,total_confidence_resize)*current_max_weighting;
end
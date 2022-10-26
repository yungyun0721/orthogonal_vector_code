function R=r_localization(settings,xdim,loc)
    localization_radius = settings.letkf.rlocalization.radius(xdim);
    
    increase_func = @(dist) exp((loc.dist.^2)./(2*localization_radius^2));
    increase_factor = increase_func(loc.dist);
    increase_factor_map = meshgrid(increase_factor,increase_factor);
    
    R = loc.R.*increase_factor_map;
end
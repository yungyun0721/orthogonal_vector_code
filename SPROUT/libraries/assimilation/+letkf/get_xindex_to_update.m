function update_xindex = get_xindex_to_update(settings,mss,obs_available)
    model_vars = settings.model_vars;
    on_update_list = [];
    xtravel = 1;

    for vnum = 1:length(mss)
        if (sum(vnum == model_vars) == 1)
            on_update_list = [on_update_list, xtravel:xtravel+mss(vnum)-1];
        end
        xtravel = xtravel+mss(vnum);
    end
    
    update_xindex = intersect(obs_available,on_update_list); 
end
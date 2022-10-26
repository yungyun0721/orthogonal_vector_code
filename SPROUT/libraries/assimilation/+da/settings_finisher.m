function da_settings = settings_finisher(da_settings)
    da_settings = replenisher(da_settings);
    da_settings = checker(da_settings);
    da_settings = adjuster(da_settings);
end

function da_settings = replenisher(da_settings)
    da_settings.analyze_vars = union(da_settings.model_vars,da_settings.observation_vars);
end

function da_settings = checker(da_settings)
end

function da_settings = adjuster(da_settings)
    if strcmp(da_settings.analyze_method,'ETKIS')
        da_settings.inflation.multiplicative = (da_settings.inflation.multiplicative+1)^(1/da_settings.incremental.all_steps)-1;
    end
    
    if strcmp(da_settings.analyze_method,'LETKIS')
        da_settings.inflation.multiplicative = (da_settings.inflation.multiplicative+1)^(1/da_settings.incremental.all_steps)-1;
    end
end
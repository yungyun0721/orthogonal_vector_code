%% ensmember = det2ens.main(settings,det_model);
%
% create ensemble by add randn perturbation to a determinist vars

%%
function ensmember=main(settings,det_model)
    % timeshift
    if settings.ensemble.det2ens.timeshift.enable
        ensmember = det2ens.timeshift(settings,det_model);
    else
        ensmember = det2ens.justcopy(settings,det_model.determinist);
    end
    
    % perturb
    if settings.ensemble.det2ens.perturb.enable
        ensmember = det2ens.perturb_ensemble(settings,ensmember);
    end
end
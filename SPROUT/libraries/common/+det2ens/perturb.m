%% ensmember = det2ens.perturb_det2ens(settings,determinist);
%
% create ensemble by add randn perturbation to a determinist vars

%%
function ensmember=perturb(settings,determinist)
    ensmember = det2ens.justcopy(settings,determinist);
    ensmember = det2ens.perturb_ensemble(settings,ensmember);
end
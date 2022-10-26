%% ensmember = det2ens.justcopy(settings,determinist);
%
% create ensemble by just copying determinist vars

%%
function ensmember=justcopy(settings,determinist)
    [xb, mss] = da.unfold_background(determinist,1:length(determinist.vars));
    K = settings.ensemble.members;
    xb = repmat(xb,[1 K]);
    ensmember = da.fold_ensemble_background(xb,0,mss);
end
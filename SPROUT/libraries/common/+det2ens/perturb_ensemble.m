%% ensmember = det2ens.perturb_ensemble(settings,ensmember);
%
% add randn perturbation to ensmember

%%
function ensmember=perturb_ensemble(settings,ensmember)
    %% initialize
    [xb, mss] = da.unfold_ensemble_background(ensmember,1:length(ensmember{1}.vars));
    K = settings.ensemble.members;
    
    %% get ensemble perturbation
    if settings.ensemble.det2ens.perturb.rng.enable
        rng(settings.ensemble.det2ens.perturb.rng.seeds);
    end
    
    % generate standard random number
    perturbation = cell(length(mss),1);
    for vnum=1:length(mss)
        random = randn(mss(vnum),K);

        % unbias
        if settings.ensemble.det2ens.perturb.unbias
            random = bsxfun(@minus,random,mean(random,2));
        end

        % resize
        if settings.ensemble.det2ens.perturb.resize
            resize_factor = std(random,0,2)*sqrt((K-1)/K);
            random = bsxfun(@rdivide,random,resize_factor);
        end
        
        % multiple
        perturbation{vnum} = random*settings.ensemble.det2ens.perturb.perturbation{vnum};
    end
    perturbation = cell2mat(perturbation);
    
    %% add
    xa = xb+perturbation;
    
    %% finalize
    ensmember = da.fold_ensemble_background(xa,0,mss,1:length(ensmember{1}.vars));
end
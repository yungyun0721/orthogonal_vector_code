%% x_perturbation = inflation(settings,x_perturbarion);
%
% improve x_perturbation to get a better ensemble structure

%%
function x_perturbation=inflation(settings,x_perturbarion)
    %% multiplicative inflation
    x_perturbation = x_perturbarion*(1+settings.inflation.multiplicative);

    %% additive inflation
end
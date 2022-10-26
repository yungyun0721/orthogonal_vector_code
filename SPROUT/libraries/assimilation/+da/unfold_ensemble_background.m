%% [xb, mss] = da.unfold_ensemble_background(art_ensemble_background,selected_vnum);
%
% get background (xb) to be assimilated

%%
function [xb, mss]=unfold_ensemble_background(art_ensemble_background,selected_vnum)
    % initialize
    K = length(art_ensemble_background);
    temp = cell(K,1);
    
    % space info
    mss = space_size_counter(art_ensemble_background{1},selected_vnum);
    
    % get xb for each ensemble member
    for ens = 1:K
        temp{ens} = cell2mat(art_ensemble_background{ens}.vars(selected_vnum));
    end
    
    % unfold vars
    xb = cell2mat(temp)';
end
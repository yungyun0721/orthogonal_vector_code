%% background = fold_ensemble_background(xb,raw_ensemble_background,mss,selected_vnum);
%
%
%  fold xb into standard structure

%%
function background=fold_ensemble_background(xb,raw_ensemble_background,mss,selected_vnum)
    % initialize
    full_vnum = 1:length(mss);
    non_selected_vnum = setdiff(full_vnum,selected_vnum);
    
    K = size(xb,2);
    background = cell(1,K);
    for ens=1:K
        % fold xb into standard vars structure
        background{ens}.vars = mat2cell(xb(:,ens)',1,mss);
        
        % move not-assimilated background to new background
        for vnum = non_selected_vnum
            background{ens}.vars{vnum} = raw_ensemble_background{ens}.vars{vnum};
        end
    end
end
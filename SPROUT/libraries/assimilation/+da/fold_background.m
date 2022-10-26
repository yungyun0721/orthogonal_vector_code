%% background = fold_ensemble_background(xb,raw_background,mss,selected_vnum);
%
%
%  fold xb into standard structure

%%
function background=fold_background(xb,raw_background,mss,selected_vnum)
    % initialize
    full_vnum = 1:length(mss);
    non_selected_vnum = setdiff(full_vnum,selected_vnum);
    
    %% fold xb into standard vars structure
    background.vars = mat2cell(xb',1,mss);
    
    %% move not-assimilated background to new background
    for vnum = non_selected_vnum
        background.vars{vnum} = raw_background.vars{vnum};
    end
end
%% [xb, mss] = da.unfold_background(background,selected_vnum);
%
% get background (xb) to be assimilated

%%
function [xb, mss]=unfold_background(background,selected_vnum)
    % space info
    mss = space_size_counter(background,selected_vnum);

    % unfold vars
    xb = cell2mat(background.vars(selected_vnum))';
end
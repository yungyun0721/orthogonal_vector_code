%% [obs, oss] = da.unfold_observation(aot_observation,selected_vnum);
%
% get observation (obs) to be assimilated

%%
function [obs, oss]=unfold_observation(aot_observation,selected_vnum)
    % select available variables
    selected_vnum = intersect(selected_vnum,aot_observation.available);

    % space info
    oss = space_size_counter(aot_observation,selected_vnum);

    % select be assimilated observation (obs)
    obs = cell2mat(aot_observation.vars(selected_vnum))';
end
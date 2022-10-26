%% R = build_obs_variance(obs_collection,oss);
%
% get observation variance matrix

%%
function R=build_obs_variance(obs_collection,oss)
    O = sum(oss);
    R = eye(O,O);

    pre = 1;
    for vnum=1:length(oss)
        R(pre:pre+oss(vnum)-1,:) = R(pre:pre+oss(vnum)-1,:)*obs_collection.variance{vnum};
        pre = pre+oss(vnum);
    end
end
%% moss = model_space_counter(X,selected_vnum);
%
% count selected model/observation space size (moss)
% in SPROUT, call model space size = mss and obseravtion = oss
%
% <args>
% X = something contain vars
% selected_vnum

%%
function moss=space_size_counter(X,selected_vnum)
    moss = zeros(1,length(X.vars));
    for vnum = selected_vnum
        moss(vnum) = length(X.vars{vnum});
    end
end
%% [weighting, new_variance] = da.blue(variance);
%
% a simple implement of Best Linear Unbiased Estimation

%%
function [weighting, new_variance] = blue(variance)
    %% initialization
    weighting = zeros(size(variance));

    %% remove inf variance
    all_index      = 1:length(variance);
    invalid_index  = find(variance >= 10^6);
    valid_index    = setxor(all_index,invalid_index);
    valid_variance = variance(valid_index);

    %% calaculate weighting
    prod_of_all  = prod(valid_variance);
    reciprocal   = valid_variance.^(-1);
    denominator  = sum(reciprocal)*prod_of_all;
    uninumerator = reciprocal.*prod_of_all;
    weighting(valid_index) = uninumerator/denominator;

    %% new_variance
    new_variance = (sum(reciprocal))^(-1);
end
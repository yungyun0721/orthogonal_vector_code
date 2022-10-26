function output=diag_u(obj,record_num)
    if (~exist('record_num','var'))
        record_num = 0;
    end
    [h, hu]=obj.selector(record_num);
    output = hu./h;
end
%% output = diag_vg(obj,record_num)
%

%%
function output=diag_vg(obj,record_num)
    if (~exist('record_num','var'))
        record_num = 0;
    end
    h = obj.selector(record_num);
    output = obj.parm.g/obj.parm.f*(shift.mirror(h,+1)-shift.mirror(h,-1))/(2*obj.map{1}.dx);
end
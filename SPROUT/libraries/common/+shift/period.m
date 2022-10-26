%% output_var = shift.period(input_var,shift_size);
%
%
%

%%
function output_var = period(input_var,shift_size)
    if (shift_size>0)
        output_var = [input_var(:,1+shift_size:end), input_var(:,1:shift_size)];
    else
        output_var = [input_var(:,end+shift_size+1:end), input_var(:,1:end+shift_size)];
    end
return
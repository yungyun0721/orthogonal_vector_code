%% output_var = shift.mirror(input_var,signal);
%
%
%

%%
function output_var = mirror(input_var,signal)
    if (signal == +1)
        output_var = [input_var(:,2:end), input_var(:,end)];
    elseif (signal == -1)
        output_var = [input_var(:,1), input_var(:,1:end-1)];
    else
        error('npshift only shift for one unit')
    end
end
%% atcorr = diagnose.point_time_scale(determinist,analyze_length);
%
% calculate the auto-correlation for the temporal characteristic
% to diagnose the time scale of variable behavior
%

%%
function output = point_time_scale(determinist,analyze_length)
    %% initialize
    total_length = determinist.record.num;
    vlength = length(determinist.record.vars);
    if (analyze_length > total_length)
        error('diagnose.space_time_scale : analyze_length > total_length')
    end
    
    data = cell(1,vlength);
    for vnum=1:vlength
        data{vnum} = determinist.record.vars{vnum}(1:total_length,:);
    end
    
    dt = determinist.record.time(3)-determinist.record.time(2);
    data_time = determinist.record.time;
    if sum(round((data_time(2:total_length)-data_time(1:total_length-1))*1000) ~= round(dt*1000))
        error('diagnose.point_time_scale : inputted data is not temporal equidistant');
    end
    output.time = (1:analyze_length)*dt;
    
    
    %% calculate auto-correlation
    for vnum = 1:vlength
        %% new
        diagindex = logical(eye(length(data{vnum}(1,:))));
        for laglength = 1:analyze_length
            select_index = 1:total_length-laglength;
            mastdata = data{vnum}(select_index,:);
            subdata = data{vnum}(select_index+laglength,:);
            
            temp = corr(mastdata,subdata);
            output.vars{vnum}(laglength) = mean(temp(diagindex));
        end
    end
end
%% tss_corr = diagnose.space_time_scale(determinist,analyze_length);
%
% calculate the auto-correlation for the space characteristic
% to diagnose the time scale of space pattern
%

%%
function output = space_time_scale(determinist,analyze_length)
    %% initialize
    total_length = determinist.record.num;
    vlength = length(determinist.record.vars);
    if (analyze_length > total_length/2)
        warning('diagnose.space_time_scale : analyze_length > total_length/2, there will be folded')
    end
    
    data = cell(1,vlength);
    correlation = null([vlength,total_length,analyze_length]);
    for vnum=1:vlength
        data{vnum} = determinist.record.vars{vnum}(1:total_length,:);
    end
    
    dt = determinist.record.time(3)-determinist.record.time(2);
    data_time = determinist.record.time;
    if sum(round((data_time(2:total_length)-data_time(1:total_length-1))*1000) ~= round(dt*1000))
        error('diagnose.space_time_scale : inputted data is not temporal equidistant');
    end
    output.time = (1:analyze_length)*dt;
    
    
    %% calculate correlation
    for vnum = 1:vlength
        for mastdata_time = 1:total_length
            mastdata = data{vnum}(mastdata_time,:);

            for subdata_time = 1:analyze_length
                subdata_time_index = mod(mastdata_time+subdata_time-1,total_length)+1;
                subdata = data{vnum}(subdata_time_index,:);

                temp = corrcoef(mastdata,subdata);
                correlation(vnum,mastdata_time,subdata_time) = temp(1,2);
            end
        end
        output.vars{vnum} = squeeze(mean(correlation(vnum,:,:)));
    end
end
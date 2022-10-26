function [figurehandle,linehandle,titlehandle,ploted_var]=plot_snap(obj,timestep,newfig)
    %% this function will plot h
    ploted_var = 1;
    
    %% check and read the time
    if (~exist('timestep','var'))
        timestep = obj.record.num;
    end
    time = obj.record.time(timestep);
    
    %% check create a new figure or not
    if (exist('newfig','var') && newfig==1)
        figurehandle = figure;
    elseif (~exist('newfig','var') || newfig==0)
        figurehandle = 0;
    else
        error('plot_snap : wrong arg (newfig)')
    end
    
    %% prepare data
    if obj.periodical
        xx = obj.map{1}.enlarged_periodical_coordinate;
        value = obj.enlarged_periodical_data(1);
    else
        xx = obj.map{1}.coordinate;
        value = obj.record.vars{1};
    end
    
    %% plot figure
    % plot lines
    linehandle{1} = plot(xx,value(timestep,:),'b','linewidth',2);
    % adjust figure and write legend, title
    legend(linehandle{1},'h')
    xlim([0 obj.map{1}.domain_size])
    mean_h = mean(obj.record.vars{1}(1,:));
    max_shock = max(abs(obj.record.vars{1}(1,:)-mean_h));
    min_h = mean_h-max_shock*1.5;
    max_h = mean_h+max_shock*1.5;
    ylim([min_h max_h])
    titlehandle = title(['time : ',num2str(time)]);
end
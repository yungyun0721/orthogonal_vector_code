function [figurehandle,linehandle,titlehandle,ploted_var]=plot_snap(obj,timestep,newfig)
    %% this function will plot X and Y
    ploted_var = [1,2];
    
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
    xx{1} = obj.map{1}.enlarged_periodical_coordinate;
    xx{2} = obj.map{2}.enlarged_periodical_coordinate;
    value{1} = obj.enlarged_periodical_data(1);
    value{2} = obj.enlarged_periodical_data(2);
    
    %% plot figure
    % plot lines
    plot([0 360],[0 0],'k')
    hold on
    linehandle{1} = plot(xx{1},value{1}(timestep,:),'b','linewidth',2);
    linehandle{2} = plot(xx{2},value{2}(timestep,:),'r');
    % adjust figure and write legend, title
    legend([linehandle{1} linehandle{2}],'X','Y')
    xlim([0 360])
    ylim([-4 10])
    set(gca,'xtick',0:45:360)
    titlehandle = title(['time : ',num2str(time)]);
end
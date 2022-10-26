function [figurehandle,linehandle,titlehandle,ploted_var]=plot_snap(obj,timestep,newfig)
    %% this function will plot h
    ploted_var = [1, 2, 3];
    
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
        value{1} = obj.enlarged_periodical_data(1);
        value{2} = obj.enlarged_periodical_data(2);
        value{3} = obj.enlarged_periodical_data(3);
    else
        xx = obj.map{1}.coordinate;
        value{1} = obj.record.vars{1};
        value{2} = obj.record.vars{2};
        value{3} = obj.record.vars{3};
    end
    
    %% plot figure
    % plot lines
    hold on
    linehandle{3} = plot(xx,value{3}(timestep,:),'b','linewidth',1);
    linehandle{2} = plot(xx,value{2}(timestep,:),'r','linewidth',1);
    linehandle{1} = plot(xx,value{1}(timestep,:),'g','linewidth',2);

    % legend
    legend([linehandle{1}, linehandle{2}, linehandle{3}],'h','u','v')

    % adjust figure and write legend, title
    xlim([0 obj.map{1}.domain_size])
    maxh = max(max(value{1}(1:obj.record.num,:)));
    minh = min(min(value{1}(1:obj.record.num,:)));
    dh = maxh-minh;
    ylim([minh-0.2*dh maxh+0.2*dh])
    
%     mean_h = mean(value{1},2);
%     max_shock = max(max(abs(bsxfun(@minus,value{1},mean_h))))
%     min_h = mean_h-max_shock*1.5;
%     max_h = mean_h+max_shock*1.5;
%     ylim([min_h max_h])

    % title
    titlehandle = title(['time : ',num2str(time)]);
end
function [figurehandle, contourf_c, contourf_h]=plot_evolution(obj,var_nums,period)
    if (~exist('period','var'))
        period = 1:obj.record.num;
    end
    
    t = obj.record.time(period);
    if (obj.periodical == 1)
        x     = obj.map{var_nums}.enlarged_periodical_coordinate;
        value = obj.enlarged_periodical_data(var_nums);
    else
        x     = obj.map{var_nums}.coordinate;
        value = obj.record.vars{var_nums};
    end
    [xx,tt] = meshgrid(x,t);
    
    figurehandle = figure;
    [contourf_c, contourf_h] = contourf(xx,tt,value(period,:),20,'linestyle','none');
    
    xlabel('x')
    ylabel('time')
    xlim([0 obj.map{var_nums}.domain_size])
    ylim([t(1) t(end)])
end
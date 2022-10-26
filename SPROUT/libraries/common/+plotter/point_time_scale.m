function [handles, pts] = point_time_scale(determinist,analyze_length,time_multiplier)
    if (~exist('time_multiplier','var'))
        time_multiplier = 1;
    end

    pts = diagnose.point_time_scale(determinist,analyze_length);
    colors = 'brgmc';
    
    handles.figure = figure;
    
    plot([0 pts.time(end)*time_multiplier],[exp(-1) exp(-1)],'k:')
    hold on
    plot([0 pts.time(end)*time_multiplier],[-exp(-1) -exp(-1)],'k:')
    plot([0 pts.time(end)*time_multiplier],[0 0],'k:')
    for vnum = 1:length(pts.vars)
        plot([0, pts.time*time_multiplier],[1, pts.vars{vnum}],colors(vnum),'linewidth',2)

        efold_index = find((pts.vars{vnum}-exp(-1))<0);
        efold_index = efold_index(1);

        plot([pts.time(efold_index)*time_multiplier pts.time(efold_index)*time_multiplier],[-1.05 1.05],[colors(vnum),':']);
        text(pts.time(efold_index)*time_multiplier,0.8,num2str(pts.time(efold_index)*time_multiplier),'fontsize',12)
    end
    
    xlim([0 pts.time(end)*time_multiplier])
    ylim([-1.05 1.05])
end
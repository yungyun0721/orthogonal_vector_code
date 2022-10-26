function figurehandle=plot_animation(obj,period,density,pauset)
    %% check arg
    if (~exist('period','var') || sum(period==0))
        period = 1:obj.record.num;
        if (~exist('density','var'))
            density = 2;
        end
    end
    if (~exist('pauset','var'))
        pauset = 0;
    end
    
    %% initialize
    [figurehandle,linehandle,titlehandle,ploted_var] = obj.plot_snap(period(1),1);
    for vnum=1:length(ploted_var)
        set(linehandle{vnum},'EraseMode','background');
    end
    set(titlehandle,'EraseMode','normal');
    
    %% pre-save vars
    value = cell(1,3);
    for vnum=1:length(ploted_var)
        if (obj.periodical == true)
            value{vnum} = obj.enlarged_periodical_data(ploted_var(vnum));
        else
            value{vnum} = obj.record.vars{ploted_var(vnum)};
        end
    end
    
    %% plot animation
    for timestep = period
        if (mod(timestep,density)==0)
            time = obj.record.time(timestep);
            set(titlehandle,'String',['time : ',num2str(time)]);
        end
        for vnum=1:length(ploted_var)
            set(linehandle{vnum},'ydata',value{vnum}(timestep,:));
        end
        drawnow
        pause(pauset)
    end
end
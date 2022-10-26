function lorenz96_RMSE_plotter(truth, fr_run, da_run)
%%
    da_run_rmse = diagnose.all_time_rmse(truth,da_run);
    fr_run_rmse = diagnose.all_time_rmse(truth,fr_run);
    % obs_run_rmse = diagnose.all_time_rmse(truth,observation);
    da_run_es = diagnose.all_time_es(da_run);
    mid_time = max(da_run_rmse.time)/2;
    index = record.category_by_note(da_run.ensmean.record);
    
    disp('vars : X')
%     disp(['DA (BG)       RMSE = ',num2str(mean(da_run_rmse.vars{1}(index.forecast(da_run_rmse.time(index.forecast)>=mid_time))))])
    disp(['DA (Analysis) RMSE = ',num2str(mean(da_run_rmse.vars{1}(index.analysis(da_run_rmse.time(index.analysis)>=mid_time))))])
    disp(['Free          RMSE = ',num2str(mean(fr_run_rmse.vars{1}(fr_run_rmse.time>=mid_time)))])
    % disp(['Observation, RMSE = ',num2str(mean(obs_run_rmse.vars{1}(judge_index)))])
%     disp(['DA (BG)       M-ES = ',num2str(mean(da_run_es.mean.vars{1}(index.forecast(da_run_rmse.time(index.forecast)>=mid_time))))])
    disp(['DA (Analysis) M-ES = ',num2str(mean(da_run_es.mean.vars{1}(index.analysis(da_run_rmse.time(index.analysis)>=mid_time))))])
    
    disp('vars : Y')
%     disp(['DA (BG)       RMSE = ',num2str(mean(da_run_rmse.vars{2}(index.forecast(da_run_rmse.time(index.forecast)>=mid_time))))])
    disp(['DA (Analysis) RMSE = ',num2str(mean(da_run_rmse.vars{2}(index.analysis(da_run_rmse.time(index.analysis)>=mid_time))))])
    disp(['Free          RMSE = ',num2str(mean(fr_run_rmse.vars{2}(fr_run_rmse.time>=mid_time)))])
    % disp(['Observation, RMSE = ',num2str(mean(obs_run_rmse.vars{2}(judge_index)))])
%     disp(['DA (BG)       M-ES = ',num2str(mean(da_run_es.mean.vars{2}(index.forecast(da_run_rmse.time(index.forecast)>=mid_time))))])
    disp(['DA (Analysis) M-ES = ',num2str(mean(da_run_es.mean.vars{2}(index.analysis(da_run_rmse.time(index.analysis)>=mid_time))))])

   
    xplot = figure;
     x_obs_rmse = plot([fr_run_rmse.time(1) fr_run_rmse.time(end)]*5,[1 1],'m:','linewidth',2);
%      x_obs_rmse = plot(obs_run_rmse.time*5,obs_run_rmse.vars{1},'m:','linewidth',2);
    hold on
    x_da_es = plot(da_run_es.time*5,da_run_es.mean.vars{1},'c','linewidth',3);
    x_da_rmse = plot(da_run_rmse.time*5,da_run_rmse.vars{1},'b','linewidth',2.5);
    x_fr_rmse = plot(fr_run_rmse.time*5,fr_run_rmse.vars{1},'g','linewidth',2.5);
    a = legend([x_da_rmse;x_fr_rmse;x_obs_rmse;x_da_es],'RMSE : da run','RMSE : free run','RMSE : obs','M-ES : da run');
    set(a,'fontsize',14)
    xlabel('Time (days)','fontsize',14)
    ylabel('RMS X error','fontsize',14)
    ylim([0 10])
    xlim([0 fr_run_rmse.time(end)*5+0.001])
%%
    yplot = figure;
    y_obs_rmse = plot([fr_run_rmse.time(1) fr_run_rmse.time(end)]*5,[0.05 0.05],'m:','linewidth',2);
    % y_obs_rmse = plot(obs_run_rmse.time*5,obs_run_rmse.vars{2},'m:','linewidth',2);
    hold on
    y_da_es = plot(da_run_es.time*5,da_run_es.mean.vars{2},'c','linewidth',3);
    y_da_rmse = plot(da_run_rmse.time*5,da_run_rmse.vars{2},'b','linewidth',2.5);
    y_fr_rmse = plot(fr_run_rmse.time*5,fr_run_rmse.vars{2},'g','linewidth',2.5);
    a = legend([y_da_rmse;y_fr_rmse;y_obs_rmse;y_da_es],'RMSE : da run','RMSE : free run','RMSE : obs','M-ES : da run');
    set(a,'fontsize',14)
    xlabel('Time (days)','fontsize',14)
    ylabel('RMS Y error','fontsize',14)
    ylim([0 0.5])
    xlim([0 50])

    set(xplot, 'Position', [0, 0, 900, 800]);
    set(yplot, 'Position', [0, 0, 900, 800]);
end
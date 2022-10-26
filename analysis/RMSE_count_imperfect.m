load('truth_truth.mat');
truth=truth_truth;
load("control_da_run.mat");
da_times=32;
for i=51:599
           % find large local
    select_localization=3;
    [c,k]=max(abs(control_da_run.ensmean.record.vars{1}((i*da_times),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)));
    select_local=mod(k-select_localization:k+select_localization,40);
       for u= 1:2*select_localization+1
           if  select_local(1,u)==0
               select_local(1,u)=40;
           end
       end
    con_tt=(control_da_run.ensmean.record.vars{1}((i*da_times)+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
    con_tt1=(control_da_run.ensmean.record.vars{1}((i*da_times),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
    con_analysis_for_max_F_T_7(i-50,1)=sqrt(mean(con_tt));
    con_analysis_for_max_F_T_7(i-50,2)=sqrt(mean(con_tt1));
end
large_RMSE=mean(con_analysis_for_max_F_T_7(:,1))+ 2*std(con_analysis_for_max_F_T_7(:,1),0,1);
large_RMSE_1std=mean(con_analysis_for_max_F_T_7(:,1))+ 1*std(con_analysis_for_max_F_T_7(:,1),0,1);
%% count whole domain rmse mean std
control_da_run_rmse = diagnose.all_time_rmse(truth_truth,control_da_run);
da_times=32;
for i=51:599
    tt_for_times=(i*(da_times)):((i+1)*(da_times)-1);
    control_rmse(i-50,1:32)=control_da_run_rmse.vars{1}(tt_for_times,1); 
end
%% imperfect_control_run
load("da_run_imperfect_inf_23_control.mat");
da_times=32;
da_run_imperfect_control = da_run_imperfect_inf_23_control; 
for i=51:599
           % find large local
    select_localization=3;
    [c,k]=max(abs(da_run_imperfect_control.ensmean.record.vars{1}((i*da_times),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)));
    select_local=mod(k-select_localization:k+select_localization,40);
       for u= 1:2*select_localization+1
           if  select_local(1,u)==0
               select_local(1,u)=40;
           end
       end
    con_tt=(da_run_imperfect_control.ensmean.record.vars{1}((i*da_times)+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
    con_tt1=(da_run_imperfect_control.ensmean.record.vars{1}((i*da_times),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
    imp_con_analysis_for_max_F_T_7(i-50,1)=sqrt(mean(con_tt));
    imp_con_analysis_for_max_F_T_7(i-50,2)=sqrt(mean(con_tt1));
end
%% count whole domain rmse mean std
imp_control_da_run_rmse = diagnose.all_time_rmse(truth_truth,da_run_imperfect_control);
da_times=32;
for i=51:599
    tt_for_times=(i*(da_times)):((i+1)*(da_times)-1);
    imp_control_rmse(i-50,1:32)=imp_control_da_run_rmse.vars{1}(tt_for_times,1); 
end
%% RUN online imperfect_orth_IESV1
load('da2_run_imperfect_inf_23_orth_IESV.mat');
da2_online_run=da2_run_imperfect_inf_23_orth_IESV;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    imp_da22_forecast_online_orth_IESV(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    imp_da22_forecast_online_orth_IESV(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% RUN online imperfect_orth_ensmean
load('da2_run_imperfect_inf_23_orth_ensmean.mat');
da2_online_run=da2_run_imperfect_inf_23_orth_ensmean;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    imp_da22_forecast_online_orth_ensmean(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    imp_da22_forecast_online_orth_ensmean(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% RUN online imperfect_8_ens_orth_IESV_orth_ensmean
load('da2_run_imperfect_inf_23_8_ens_orth_IESV_orth_ensmean.mat');
da2_online_run=da2_run_imperfect_inf_23_8_ens_orth_IESV_orth_ensmean;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    imp_da22_forecast_online_8_ens_orth_IESV_orth_ensmean(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    imp_da22_forecast_online_8_ens_orth_IESV_orth_ensmean(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%%
load('da2_run_imperfect_inf_19_7_ens');
da2_online_run=da2_run_imperfect_inf_19_7_ens;
da2_online_run = select_refresh_ensmean(da2_online_run,1:7);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    imp_da22_forecast_online_7_ens(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    imp_da22_forecast_online_7_ens(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% whole domain 1std~2std & >2std
% con_std=std(control_rmse(:,2),0,1);
% con_mean=mean(control_rmse(:,2));
con_std=std(imp_control_rmse(:,2),0,1);
con_mean=mean(imp_control_rmse(:,2));
k=1;
w=1;
clear large_time large2_time
for i=51:599
    if imp_control_rmse(i-50,2)>=con_mean+con_std && imp_control_rmse(i-50,2)<=con_mean+con_std*2
        large_time(k,1)=i-50;
        k=k+1;
    end
    if imp_control_rmse(i-50,2)>=con_mean+con_std*2 
        large2_time(w,1)=i-50;
        w=w+1;
    end
end
%% online Forecast RMSE (all)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
%  select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
%f2(2)=plot(0:30,mean(control_rmse(select_time,2:32)),'k--','linewidth',1.5);hold on
f2(3)=plot(0:30,mean(imp_control_rmse(select_time,2:32)),'k-','linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(mean(da22_forecast_online_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(4)=plot(0:30,mean(da22_forecast_online_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(da22_forecast_online_IESV(select_time,2:32)),'color',[230 0 51]./255,'linewidth',1.5);hold on
% f2(4)=plot(0:30,mean(imp_da22_forecast_online_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
% f2(5)=plot(0:30,mean(da22_forecast_online_ensmean(select_time,2:32)),'color',[0 153 51]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(imp_da22_forecast_online_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on

% f2(7)=plot(0:30,mean(da22_forecast_online_8_ens_orth_IESV_SVD(select_time,2:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,mean(imp_da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(9)=plot(0:30,mean(imp_da22_forecast_online_7_ens(select_time,2:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:8)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:9)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,[3 6 8 9])'],'Control run','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,[2 3 4 5 6 8 9])'],'Control run','IESV','Orth IESV','Ensmean','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')



xlabel('Time step','fontsize',16);
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE','fontsize',16);
xlim([-2 31]);
legend('boxoff');
set(gca,'FontSize',16);
% print('-f1','-dpng','-r800',['imperfect online forecast (best) all.png']);
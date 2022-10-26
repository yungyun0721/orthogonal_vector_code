%% online Forecast RMSE improvement (ALL)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
% select_time=large2_time;
select_time=large2_time;
% select_time=small_time;
figure;
% plot(0:30,mean(control_rmse),'k-');hold on
% for i=1:20
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end

f2(2)=plot(-1:30,mean(control_rmse(select_time,:))-mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(3)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(4)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_8_ens_orth_IESV_SVD(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(7)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[255 153 204]./255,'linewidth',1.5);hold on
f2(8)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on

legend([f2(1,2:8)'],'Average rand SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
xlabel('Time step');
ylabel('Forecast RMSE improvement');
xlim([-2 31]);
% 
% control_rmse
% da22_forecast_svd_rmse

%% online Forecast RMSE (SVD)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

for i=1:20
f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
end
f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(4)=plot(-1:30,mean(da22_forecast_online_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(da22_forecast_online_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(da22_forecast_online_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(7)=plot(-1:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(8)=plot(-1:30,mean(da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
 legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
 
xlabel('Time step');
%ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE');
xlim([-2 31]);
% 
% 
% control_rmse
% da22_forecast_svd_rmse
%% online Forecast RMSE improvement (SVD)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;
% plot(0:30,mean(control_rmse),'k-');hold on
% for i=1:20
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end

f2(2)=plot(-1:30,mean(control_rmse(select_time,:))-mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(3)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(4)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(control_rmse(select_time,:))-mean(da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on

legend([f2(1,2:6)'],'Average rand SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
xlabel('Time step');
ylabel('Forecast RMSE improvement');
xlim([-2 31]);
% ylim([0 0.35]);
% 
% control_rmse
% da22_forecast_svd_rmse

%% offline Forecast RMSE improvement (SVD)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
% select_time=large2_time;
% select_time=small_time;
figure;

for i=1:20
f2(2)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
end
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
f2(3)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

f2(4)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_IESV(select_time,2:32)),'color',[230 0 51]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(7)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on

% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:7)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,2:7)'],'Random SVD','Average Random SVD','Orth vector from SVD','IESV','Orth IESV','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')



xlabel('Time step');
ylabel('Forecast RMSE improvement');
% ylabel('Forecast RMSE');
xlim([-2 31]);
legend('boxoff');
% 
% control_rmse
% da22_forecast_svd_rmse
%% offline Forecast RMSE(SVD)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
% select_time=large2_time;
% select_time=small_time;
figure;

for i=1:20
f2(2)=plot(-1:30,mean(da22_forecast_offline_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
end
f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
f2(3)=plot(-1:30,mean(mean(da22_forecast_offline_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(4)=plot(-1:30,mean(da22_forecast_offline_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(da22_forecast_offline_IESV(select_time,1:32)),'color',[230 0 51]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(da22_forecast_offline_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(7)=plot(-1:30,mean(da22_forecast_offline_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on

% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:7)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','IESV','Orth IESV','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')



xlabel('Time step');
ylabel('Forecast RMSE improvement');
% ylabel('Forecast RMSE');
xlim([-2 31]);%ylim([3.5 4]);
legend('boxoff');
% 
% 
% control_rmse
% da22_forecast_svd_rmse
%% online Forecast RMSE improvement (8member)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(2)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(3)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(4)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_8_ens_orth_IESV_SVD(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[255 102 204]./255,'linewidth',1.5);hold on
f2(7)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on
 
% legend([f2(2,:)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:6)'],'Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,2:7)'],'Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step');
ylabel('Forecast RMSE improvement');
% ylabel('Forecast RMSE');
xlim([-2 31]);
% 
% 
%% online Forecast RMSE (SVD)
% first run forecast_error_count;
%run RMSE_count;
%select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
f2(2)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(4)=plot(-1:30,mean(da22_forecast_online_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(da22_forecast_online_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(da22_forecast_online_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(7)=plot(-1:30,mean(da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,2:7)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step');
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE');
xlim([-2 31]);
% 
% 
% control_rmse
% da22_forecast_svd_rmse
%% offline Forecast RMSE (8,9member)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(2)=plot(-1:30,mean(da22_forecast_offline_orth_svd(select_time,1:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(3)=plot(-1:30,mean(da22_forecast_offline_orth_IESV(select_time,1:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(4)=plot(-1:30,mean(da22_forecast_offline_orth_ensmean(select_time,1:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(5)=plot(-1:30,mean(da22_forecast_offline_8_ens_orth_IESV_SVD(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(6)=plot(-1:30,mean(da22_forecast_offline_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[255 102 204]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_offline_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,1:6)'],'Control run','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step');
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE');
xlim([-2 31]);
%% offline Forecast RMSE (all)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
for i=1:20
f2(2)=plot(0:30,mean(da22_forecast_offline_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
end
f2(1)=plot(0:30,mean(control_rmse(select_time,2:32)),'k--','linewidth',1.5);hold on
f2(3)=plot(0:30,mean(mean(da22_forecast_offline_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

f2(4)=plot(0:30,mean(da22_forecast_offline_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,mean(da22_forecast_offline_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(da22_forecast_offline_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(7)=plot(0:30,mean(da22_forecast_offline_8_ens_orth_IESV_SVD(select_time,2:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,mean(da22_forecast_offline_8_ens_orth_IESV_orth_ensmean(select_time,2:32)),'color',[255 102 204]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_offline_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,1:8)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step','fontsize',16);
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE','fontsize',16);
xlim([-2 31]);
% ylim([2.6 2.9])
legend('boxoff');
set(gca,'FontSize',16);

% print('-f2','-dpng','-r500',['offline_2std_all.png']);
%% online Forecast RMSE (all)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
f2(2)=plot(0:30,mean(control_rmse(select_time,2:32)),'k--','linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(mean(da22_forecast_online_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(4)=plot(0:30,mean(da22_forecast_online_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(da22_forecast_online_IESV(select_time,2:32)),'color',[230 0 51]./255,'linewidth',1.5);hold on
f2(4)=plot(0:30,mean(da22_forecast_online_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
% f2(5)=plot(0:30,mean(da22_forecast_online_ensmean(select_time,2:32)),'color',[0 153 51]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(da22_forecast_online_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on

% f2(7)=plot(0:30,mean(da22_forecast_online_8_ens_orth_IESV_SVD(select_time,2:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(9)=plot(0:30,mean(da22_forecast_online_7_ens(select_time,2:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:8)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:9)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,[2 5 6 8 9])'],'Control run','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,[2 3 4 5 6 8 9])'],'Control run','IESV','Orth IESV','Ensmean','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')



xlabel('Time step','fontsize',16);
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE','fontsize',16);
xlim([-2 31]);
legend('boxoff');
set(gca,'FontSize',16);
print('-f1','-dpng','-r800',['online forecast (best) q3.png']);
%% offline Forecast RMSE (all)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
% select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
% for i=1:20
% f2(2)=plot(0:30,mean(da22_forecast_offline_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
f2(1)=plot(0:30,mean(control_rmse(select_time,2:32)),'k--','linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(mean(da22_forecast_offline_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(4)=plot(0:30,mean(da22_forecast_offline_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
% f2(5)=plot(0:30,mean(da22_forecast_offline_IESV(select_time,2:32)),'color',[230 0 51]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,mean(da22_forecast_offline_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(da22_forecast_offline_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
% f2(7)=plot(0:30,mean(da22_forecast_offline_8_ens_orth_IESV_SVD(select_time,2:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,mean(da22_forecast_offline_8_ens_orth_IESV_orth_ensmean(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,1:8)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','IESV','Orth IESV','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,[1 5 6 8])'],'Control run','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')



xlabel('Time step','fontsize',16);
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE','fontsize',16);
xlim([-2 31]);%ylim([2.6 2.9])
legend('boxoff');
% print('-f2','-dpng','-r500',['offline_2std_all.png']);
set(gca,'FontSize',16);
%% offline Forecast RMSE improvement (all)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

for i=1:20
f2(2)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_svd_rmse(select_time,2:32,i)))./mean(control_rmse(select_time,2:32))*100,'color',[230 230 230]./255,'linewidth',1.5);hold on
end
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
f2(3)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(mean(da22_forecast_offline_svd_rmse(select_time,2:32,:),3)))./mean(control_rmse(select_time,2:32))*100,'k-','linewidth',1.5);hold on

f2(4)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_orth_svd(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_orth_IESV(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[102 255 0]./255,'linewidth',1.5);hold on

f2(7)=plot(0:30,mean((control_rmse(select_time,2:32))-mean(da22_forecast_offline_8_ens_orth_IESV_SVD(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,mean((control_rmse(select_time,2:32))-mean(da22_forecast_offline_8_ens_orth_IESV_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[255 102 204]./255,'linewidth',1.5);hold on

% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on

% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:7)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:8)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step','fontsize',16);
ylabel('Forecast RMSE improvement (%)','fontsize',16);
% ylabel('Forecast RMSE');
xlim([-2 31]);

% ylim([0 0.2])
set(gca,'FontSize',16);
%% online Forecast RMSE improvement (all)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
% select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(1)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_online_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on
f2(2)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(mean(da22_forecast_online_svd_rmse(select_time,2:32,:),3)))./mean(control_rmse(select_time,2:32))*100,'k-','linewidth',1.5);hold on
f2(3)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_orth_svd(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(4)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_orth_IESV(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_8_ens_orth_IESV_SVD(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(7)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[255 102 204]./255,'linewidth',1.5);hold on
% f2(8)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_7_ens(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on
 
% legend([f2(2,:)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:6)'],'Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:8)'],'Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,2:7)'],'Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step','fontsize',16);
ylabel('Forecast RMSE improvement (%)','fontsize',16);
% ylabel('Forecast RMSE');
xlim([-2 31]);
% ylim([15 45]);
legend('boxoff');
set(gca,'FontSize',16);
%% offline Forecast RMSE improvement (orth and no orth)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(4)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_offline_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_IESV(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[230 0 51]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_orth_IESV(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(7)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[0 153 51]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_offline_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[102 255 0]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,1:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
% f2(7)=plot(-1:30,mean(mean(control_rmse(select_time,:))-da22_forecast_online_7_ens(select_time,1:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on

% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:7)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:7)'],'Random SVD','Average Random SVD','Orth vector from SVD','IESV','Orth IESV','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,5:8)'],'IESV','Orth IESV','Ensmean','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')



xlabel('Time step','fontsize',16);
ylabel('Forecast RMSE improvement (%)','fontsize',16);
% ylabel('Forecast RMSE');
xlim([-2 31]);
legend('boxoff');
set(gca,'FontSize',16);
%% online Forecast RMSE (orth and no orth)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;
f2(1)=plot(0:30,mean(control_rmse(select_time,2:32)),'k-','linewidth',1.5);hold on
% for i=1:20
%     f2(2)=plot(0:30,mean(da22_forecast_online_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
f2(3)=plot(0:30,mean(mean(da22_forecast_online_svd_rmse(select_time,2:32,:),3),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
f2(4)=plot(0:30,mean(da22_forecast_online_IESV(select_time,2:32)),'color',[230 0 51]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,mean(da22_forecast_online_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(da22_forecast_online_ensmean(select_time,2:32)),'color',[0 153 51]./255,'linewidth',1.5);hold on
f2(7)=plot(0:30,mean(da22_forecast_online_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:9)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','IESV','Orth IESV','Ensmean','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,[1 3 4 5 6 7])'],'Control run','Average Random SVD','IESV','Orth IESV','Ensmean','Orth Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step','fontsize',16);
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE','fontsize',16);
xlim([-2 31]);
legend('boxoff');
set(gca,'FontSize',16);
% print('-f2','-dpng','-r500',['online_orth_all.png']);
%% online Forecast RMSE (best)
% first run forecast_error_count;
%run RMSE_count;
% select_time=1:549;
% select_time=large_time;
select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(2)=plot(-1:30,mean(da22_forecast_online_svd_rmse(select_time,1:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
f2(2)=plot(0:30,mean(control_rmse(select_time,2:32)),'k-','linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(mean(da22_forecast_online_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on

% f2(4)=plot(0:30,mean(da22_forecast_online_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
% f2(5)=plot(0:30,mean(da22_forecast_online_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(3)=plot(0:30,mean(da22_forecast_online_orth_ensmean(select_time,2:32)),'color',[102 255 0]./255,'linewidth',1.5);hold on
% f2(4)=plot(0:30,mean(da22_forecast_online_8_ens_orth_IESV_SVD(select_time,2:32)),'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,mean(da22_forecast_online_7_ens(select_time,2:32)),'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
 
% legend([f2(1,:)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:8)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:9)'],'Control run','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:6)'],'Control run','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,[2 3 5 6])'],'Control run','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step','fontsize',16);
% ylabel('Forecast RMSE improvement');
ylabel('Forecast RMSE','fontsize',16);
xlim([-2 31]);
legend('boxoff');
set(gca,'FontSize',16);
%% online Forecast RMSE improvement (best)
% first run forecast_error_count;
%run RMSE_count;
select_time=1:549;
% select_time=large_time;
% select_time=large2_time;
% select_time=small_time;
figure;

% for i=1:20
% f2(1)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_online_svd_rmse(select_time,2:32,i),1),'color',[230 230 230]./255,'linewidth',1.5);hold on
% end
% f2(1)=plot(-1:30,mean(control_rmse(select_time,:)),'k--','linewidth',1.5);hold on
% f2(3)=plot(-1:30,mean(mean(da22_forecast_online_svd_rmse(select_time,1:32,:),3),1),'k-','linewidth',1.5);hold on
% f2(2)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_svd_rmse(select_time,2:32,:),3),1),'k-','linewidth',1.5);hold on
% f2(3)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_online_orth_svd(select_time,2:32)),'color',[65 105 225]./255,'linewidth',1.5);hold on
% f2(4)=plot(0:30,mean(mean(control_rmse(select_time,2:32))-da22_forecast_online_orth_IESV(select_time,2:32)),'color',[255 153 0]./255,'linewidth',1.5);hold on
f2(5)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[102 255 0]./255,'linewidth',1.5);hold on
f2(6)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_8_ens_orth_IESV_SVD(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[51 204 204]./255,'linewidth',1.5);hold on
f2(7)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_8_ens_orth_IESV_orth_ensmean(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[255 102 204]./255,'linewidth',1.5);hold on
f2(8)=plot(0:30,(mean(control_rmse(select_time,2:32))-mean(da22_forecast_online_7_ens(select_time,2:32)))./mean(control_rmse(select_time,2:32))*100,'color',[153 51 0]./255,'linewidth',1.5);hold on
% legend([f2(1,1:7)'],'Control run','Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
plot(-1:30,zeros(1,32),'k--','linewidth',1);hold on
 
% legend([f2(2,:)'],'Random SVD','Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:6)'],'Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:8)'],'Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,2:7)'],'Average Random SVD','Orth vector from SVD','Orth IESV','Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)')%,'Observation error','Orientation','horizon')%,'Location','South')
legend([f2(1,5:8)'],'Orth Ensmean','8 members (Orth IESV+ SVD)','8 members (Orth IESV+ Orth Ensmean)','7 members')%,'Observation error','Orientation','horizon')%,'Location','South')
 


xlabel('Time step','fontsize',16);
ylabel('Forecast RMSE improvement (%)','fontsize',16);
% ylabel('Forecast RMSE');
xlim([-2 31]);
% ylim([0 20]);
legend('boxoff');
set(gca,'FontSize',16);
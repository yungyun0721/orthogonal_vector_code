%% OFFLINE  forecast error improvement
exp1=control_da_run;
exp2=da2_run_offline_svd_rand_18;
exp3=da2_run_offline_IESV;
exp4=da2_run_offline_orth_IESV;
exp5=da2_run_offline_ensmean;
exp6=da2_run_offline_orth_ensmean;
exp7=da2_run_offline_8_ens_orth_IESV_orth_ensmean;
% truth=truth_truth;
da_times=32;


%% local alpha
for i=51:599
    tt_times    = (i*da_times):((i+1)*da_times);
    tt_for_times= (i*(da_times+1))+1:((i+1)*(da_times+1)-2);
    truth_for_times = (i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    select_localization=3;
    [c,k] = max(abs(control_da_run.ensmean.record.vars{1}((i*da_times),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)));
%     u=total(i).FESV(:,1);
%     u=u./sqrt(u'*u);
%     [c(i-50,1),k]=max(abs(u));
%     [c,k]=max(abs(total(i).FESV(:,1)));
    %     k=unidrnd(40);
    select_local = mod(k-select_localization:k+select_localization,40);
       for u= 1:2*select_localization+1
           if  select_local(1,u)==0
               select_local(1,u)=40;
           end
       end
%        select_local=total_area_sent(i,:);
%% control run analysis
       con_tt=(exp1.ensmean.record.vars{1}((i*da_times)+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       con_tt1=(exp1.ensmean.record.vars{1}((i*da_times)+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_con  = exp1.ensmean.record.vars{1}((i*(da_times))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_RMSE(i-50,1) =sqrt(mean(F_T_con.^2,2));
       F_T_bk  = exp1.ensmean.record.vars{1}((i*(da_times)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_bk_rmse(i-50,1) =sqrt(mean(F_T_bk.^2,2));
         
%% SVD alpha 
       tt1=(exp2.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_SVD=exp2.ensmean.record.vars{1}((i*(da_times+1))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       SVD_RMSE(i-50,1) =sqrt(mean(F_T_SVD.^2,2));
%% IESV alpha
       tt2=(exp3.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_IESV_online_17_no_orth=exp3.ensmean.record.vars{1}((i*(da_times+1))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       IESV_RMSE(i-50,1) =sqrt(mean(F_T_IESV_online_17_no_orth.^2,2));
%% orth IESV alpha
       tt3=(exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_orth_IESV_online_17=exp4.ensmean.record.vars{1}((i*(da_times+1))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       orth_IESV_RMSE(i-50,1) =sqrt(mean(F_T_orth_IESV_online_17.^2,2));
%% ensmean alpha
       tt5=(exp5.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_neg_orth_IESV_online_17=exp5.ensmean.record.vars{1}((i*(da_times+1))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       ensmean_RMSE(i-50,1) =sqrt(mean(F_T_neg_orth_IESV_online_17.^2,2));
 %% orth ensmean alpha
       tt6=(exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       Orth_ensmean_online_17=exp6.ensmean.record.vars{1}((i*(da_times+1))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       orth_ensmean_RMSE(i-50,1) =sqrt(mean(Orth_ensmean_online_17.^2,2));
 %% 8_ens_orth_IESV_orth_ensmean
       tt8=(exp7.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       Orth_IESV1_SVD_8ens_online_17=exp7.ensmean.record.vars{1}((i*(da_times+1))+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       ens_orth_IESV_orth_ensmean_RMSE(i-50,1) =sqrt(mean(Orth_IESV1_SVD_8ens_online_17.^2,2));

end

%% plot

AA1=F_T_RMSE;
AA2=SVD_RMSE;
AA3=IESV_RMSE;
AA4=orth_IESV_RMSE;
AA5=ensmean_RMSE;
AA6=orth_ensmean_RMSE;
AA7=ens_orth_IESV_orth_ensmean_RMSE;

figure;
% f2(1)=plot(321:599,AA1(271:549,1),'k-','Linewidth',1.5);hold on
f2(1)=plot(321:599,AA1(271:549,1)*0,'k--','Linewidth',1);hold on
% f2(2)=plot(321:599,AA1(271:549,1)-AA2(271:549,1),'color',[150 150 150]./255,'Linewidth',1.5);hold on
f2(3)=plot(321:599,AA1(271:549,1)-AA3(271:549,1),'color',[230 0 51]./255,'Linewidth',1.5);hold on
f2(4)=plot(321:599,AA1(271:549,1)-AA4(271:549,1),'color',[255 153 0]./255,'Linewidth',1.5);hold on
f2(5)=plot(321:599,AA1(271:549,1)-AA5(271:549,1),'color',[0 153 51]./255,'Linewidth',1.5);hold on
% f2(6)=plot(321:599,AA1(271:549,1)-AA6(271:549,1),'color',[102 255 0]./255,'Linewidth',1.5);hold on
% f2(7)=plot(321:599,AA1(271:549,1)-AA7(271:549,1),'color',[0 102 204]./255,'Linewidth',1.5);hold on
% plot(321:599,AA3(271:549,1),'color',[255 0 51]./255,'Linewidth',1);hold on

xlim([320 600]);ylim([-1 2]);
% legend([f2(1,1:7)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Ensmean','Neg. Orth IESV','Orth IESV+Orth EMS')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,:)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Ensmean','Neg. Orth IESV','Orth IESV+Orth EMS')%,'Observation error')%,'Orientation','horizon')%,'Location','South')
%  legend('Control run','Orth IESV','Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,[1 6 7 ])'],'Control run','Ensmean','Orth Ensmean','7 member');%,'Orientation','horizon')%,'Location','South')
legend([f2(1,[1 3 4 5])'],'Control run','IESV1','Orth IESV1','Neg. Orth IESV1');%,'Orientation','horizon')%,'Location','South')

legend('boxoff');
% set(hl,'Orientation','horizon');
% xlabel('DA cycle');
ylabel('improvement ');
set(gcf,'position',[0.2 150 2000 300]);
set(gca,'position',[0.035 0.1 0.95 0.85])
set(gca,'FontSize',16);
%% control run
figure;
% f2(1)=plot(321:599,AA1(271:549,1),'k-','Linewidth',1.5);hold on
f2(1)=plot(321:599,F_T_bk_rmse(271:549,1).*0+1,'k--','Linewidth',1);hold on
f2(1)=plot(321:599,F_T_bk_rmse(271:549,1),'b--','Linewidth',1);hold on
f2(2)=plot(321:599,F_T_RMSE(271:549,1),'r-','Linewidth',1.5);hold on


xlim([320 600]);%ylim([-0.2 0.8]);
legend('boxoff');
% set(hl,'Orientation','horizon');
% xlabel('DA cycle');
ylabel('RMSE');
set(gcf,'position',[0.2 150 2000 300]);
set(gca,'position',[0.035 0.1 0.95 0.85])
set(gca,'FontSize',16);

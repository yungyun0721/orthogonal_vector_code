%% OFFLINE  forecast error
exp1=control_da_run;
exp4=da2_run_offline_orth_IESV;
exp6=da2_run_offline_orth_ensmean;
% truth=truth_truth;
da_times=32;
s_value=zeros(600,8,8);
con_max_pert = zeros(6,40);
IESV_online_17_no_orth_max_pert = zeros(1,40);
Orth_ensmean_max_pert = zeros(1,40);
con_max_percent =zeros(549,1);
cos_leave_F_T_orth_IESV1 =zeros(549,1);
cos_leave_F_T_orth_ensmean =zeros(549,1);
%% local alpha
for i=51:599
    tt_times    = (i*da_times):((i+1)*da_times);
    tt_for_times= (i*(da_times+1))+1:((i+1)*(da_times+1)-2);
    truth_for_times = (i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    select_local = 1:40;
       
%% control run alpha
       con_tt=(exp1.ensmean.record.vars{1}((i*da_times)+1,select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       con_tt1=(exp1.ensmean.record.vars{1}((i*da_times),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_con= exp1.ensmean.record.vars{1}((i*(da_times)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_con=F_T_con./sqrt(F_T_con*F_T_con');
       for j=1:6
            con_max_pert(j,:)=exp1.ensmember{j}.record.vars{1}((i*(da_times)),select_local)-exp1.ensmean.record.vars{1}((i*(da_times)),select_local);
       end
       [u_svd s_svd v_svd]=svd(con_max_pert');
       s_value(i,1:6,1)=diag(s_svd);
       ens_proj_FESV1=zeros(40,5);
       total_proj_FESV1=zeros(40,1);
       for j=1:5
            ens_proj_FESV1(:,j) = ((u_svd(:,j)'*F_T_con')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       con_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
       leave_F_T_con = F_T_con' - total_proj_FESV1;
         
%% orth IESV alpha
       tt2=(exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_IESV_online_17_no_orth=exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_IESV_online_17_no_orth=F_T_IESV_online_17_no_orth./sqrt(F_T_IESV_online_17_no_orth*F_T_IESV_online_17_no_orth');
       IESV_online_17_no_orth_max_pert=exp4.ensmember{7}.record.vars{1}((i*(da_times+1)),select_local)-exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       cos_leave_F_T_orth_IESV1(i-50,1) = IESV_online_17_no_orth_max_pert*leave_F_T_con...
           ./sqrt(IESV_online_17_no_orth_max_pert*IESV_online_17_no_orth_max_pert')...
           ./sqrt(leave_F_T_con'*leave_F_T_con);
 %% orth ensmean alpha
       tt6=(exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       Orth_ensmean_online_17=exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       Orth_ensmean_online_17=Orth_ensmean_online_17./sqrt(Orth_ensmean_online_17*Orth_ensmean_online_17');
       Orth_ensmean_max_pert=exp6.ensmember{7}.record.vars{1}((i*(da_times+1)),select_local)-exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       cos_leave_F_T_orth_ensmean(i-50,1) = Orth_ensmean_max_pert*leave_F_T_con...
           ./sqrt(Orth_ensmean_max_pert*Orth_ensmean_max_pert')...
           ./sqrt(leave_F_T_con'*leave_F_T_con);

end

%% plot

AA1=con_max_percent;
% AA2=abs(cos_leave_F_T_orth_IESV1);
% AA3=abs(cos_leave_F_T_orth_ensmean);

figure;
f2(1)=plot(321:599,AA1(271:549,1),'k-','Linewidth',1.5);hold on
% f2(2)=plot(321:599,AA2(271:549,1),'color',[255 153 0]./255,'Linewidth',1.5);hold on
% f2(3)=plot(321:599,AA3(271:549,1),'color',[102 255 0]./255,'Linewidth',1.5);hold on

xlim([320 600]);ylim([0 1]);

legend('boxoff');
% set(hl,'Orientation','horizon');
% xlabel('DA cycle');
ylabel(' \alpha ');
set(gcf,'position',[0.2 150 2000 300]);
set(gca,'position',[0.035 0.1 0.95 0.85])
set(gca,'FontSize',16);
%% scatter
figure(2);
AA1=con_max_percent;
AA2=abs(cos_leave_F_T_orth_IESV1);
AA3=abs(cos_leave_F_T_orth_ensmean);
% plot(mean(control_rmse(:,2)).*ones(11,1),0:0.1:1,'k--');hold on
% plot((mean(control_rmse(:,2))+std(control_rmse(:,2),0,1)).*ones(11,1),0:0.1:1,'k--');hold on
% plot((mean(control_rmse(:,2))+2*std(control_rmse(:,2),0,1)).*ones(11,1),0:0.1:1,'k--');hold on
con_q3=prctile(control_rmse(:,2),75);
con_q2=prctile(control_rmse(:,2),50);
plot(con_q2.*ones(11,1),0:0.1:1,'k--');hold on
plot(con_q3.*ones(11,1),0:0.1:1,'k--');hold on
scatter(control_rmse(:,2),AA3(:,1),[],AA1(:,1),'filled')
caxis([0 1])
% caxis([-10 10])
% caxis([cc_down cc_up])
% colormap(GMT_16);
% colormap(gray)
GMT_20(10,:) = [170,255,255]./255;
GMT_20(11,:) = [255,255,140]./255;
colormap(GMT_20)
% colormap(jet(nn_jet))
colorbar
%  xlabel([compare2,'(',area1,'7 grid points)']);ylabel(' \alpha ');
set(gca,'FontSize',14);
%  print('-f2','-dpng','-r800',['rest error and orth ensemble mean Q2 Q3.png']);

%% eiganvalue
for i=51:600
    for j=1:8
        s_value(i,:,j)=sqrt(s_value(i,:,j));
    end
end
mean_s = zeros(549,8,8);
for i=1:549
    for j=1:8
        mean_s(i,j,:)=s_value(i+50,:,j)./sum(s_value(i+50,:,j));
    end 
end
%%
large_time=1:549;

% ss=squeeze(mean(mean_s(51:599,:,:),1));
% ss=squeeze(mean(s_value(51:599,:,:),1))-ss(:,1);
% ss=squeeze(mean(s_value(51:599,:,:)-s_value(51:599,:,1),1)).*100;
ss=squeeze(mean(mean_s(large_time,:,:)))'.*100;
% ss=ss-ss(:,1);
figure;
f3(1)=plot(1:8,ss(:,1),'k-','Linewidth',1.5);hold on
f3(2)=plot(1:8,ss(:,2),'color',[150 150 150]./255,'Linewidth',2);hold on
% f3(2)=plot(1:8,ss(:,5),'color',[0 102 204]./255,'Linewidth',1.5);hold on
f3(4)=plot(1:8,ss(:,4),'color',[255 153 0]./255,'Linewidth',2);hold on
% f3(3)=plot(1:8,ss(:,3),'color',[255 0 51]./255,'Linewidth',1);hold on
% f3(4)=plot(1:7,ss(:,4),'color',[255 153 0]./255,'Linewidth',1);hold on

% f3(5)=plot(1:7,ss(:,5),'color',[204 0 204]./255,'Linewidth',1);hold on
f3(6)=plot(1:8,ss(:,6),'color',[102 255 0]./255,'Linewidth',2);hold on
f3(7)=plot(1:8,ss(:,7),'color',[0 102 204]./255,'Linewidth',2);hold on
% f3(7)=plot(1:8,ss(:,7),'color',[0 255 0]./255,'Linewidth',1.5);hold on
% f3(8)=plot(1:7,ss(:,8),'color',[0 102 204]./255,'Linewidth',1);hold on
% f3(9)=plot(1:7,ss(:,9),'color',[0 255 204]./255,'Linewidth',1);hold on
% f3(10)=plot(1:7,ss(:,10),'k-','color',[153 51 0]./255,'Linewidth',1,'Markersize',4);hold on
% plot(321:599,AA3(271:549,1),'color',[255 0 51]./255,
% 'Linewidth',1);hold on
% legend([f3(1,1:9)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Neg. Orth IESV','Ensmean','Orth Ensmean','Imp SVD+Orth IESV','8 member(Orth IESV1+SVD)')%,'Orientation','horizon')%,'Location','South')
legend([f3(1,[1 2 4 6 7])'],'Control run','Orth vector from SVD','Orth IESV','Orth Ensmean', '8 member(Orth IESV1+orth ensmean)')%,'Orientation','horizon')%,'Location','South')
% legend([f3(1,[1 2 4 7])'],'Control run','Orth vector from SVD','Orth IESV','Orth Ensmean')%,'Orientation','horizon')%,'Location','South')
% legend([f3(1,1:10)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Neg. Orth IESV','Ensmean','Orth Ensmean','Imp SVD+Orth IESV','8 member(Orth IESV1+SVD)','7 members')%,'Orientation','horizon')%,'Location','South')
legend('boxoff');
xlabel('mode');
ylabel('mean eigenvalue (%)');
set(gca,'FontSize',16);
xlim([1 8]);
% ylabel('mean eigenvalue value(%) (compare to control run) ');
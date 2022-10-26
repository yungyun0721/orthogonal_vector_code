%% OFFLINE  forecast error
exp1=control_da_run;
exp2=da2_run_offline_svd_rand_18;
exp3=da2_run_offline_IESV;
exp4=da2_run_offline_orth_IESV;
exp5=da2_run_offline_ensmean;
exp6=da2_run_offline_orth_ensmean;
exp7=da2_run_offline_8_ens_orth_IESV_orth_ensmean;

% truth=truth_truth;
da_times=32;
s_value=zeros(600,7,8);
con_max_pert = zeros(6,7);
SVD_max_pert = zeros(7,7);
IESV_online_17_no_orth_max_pert = zeros(7,7);
orth_IESV_online_17_max_pert = zeros(7,7);
ensmean_online_17_no_orth_max_pert = zeros(7,7);
Orth_ensmean_max_pert = zeros(7,7);
Orth_IESV1_ensmean_8ens_max_pert = zeros(8,7);

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
       ens_proj_FESV1=zeros(7,5);
       total_proj_FESV1=zeros(7,1);
       for j=1:5
            ens_proj_FESV1(:,j) = ((u_svd(:,j)'*F_T_con')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       con_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
         
%% SVD alpha 
       tt1=(exp2.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_SVD=exp2.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_SVD=F_T_SVD./sqrt(F_T_SVD*F_T_SVD');
       for j=1:7
            SVD_max_pert(j,:)=exp2.ensmember{j}.record.vars{1}((i*(da_times+1)),select_local)-exp2.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       end
       [u_svd s_svd v_svd]=svd(SVD_max_pert');
       s_value(i,1:7,2)=diag(s_svd);
       ens_proj_FESV1=zeros(7,6);
       total_proj_FESV1=zeros(7,1);
       for j=1:6
            ens_proj_FESV1(:,j)=((u_svd(:,j)'*F_T_SVD')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       SVD_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
%% IESV alpha
       tt2=(exp3.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_IESV_online_17_no_orth=exp3.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_IESV_online_17_no_orth=F_T_IESV_online_17_no_orth./sqrt(F_T_IESV_online_17_no_orth*F_T_IESV_online_17_no_orth');
       for j=1:7
            IESV_online_17_no_orth_max_pert(j,:)=exp3.ensmember{j}.record.vars{1}((i*(da_times+1)),select_local)-exp3.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       end
       [u_svd s_svd v_svd]=svd(IESV_online_17_no_orth_max_pert');
       s_value(i,1:7,3)=diag(s_svd);
       ens_proj_FESV1=zeros(7,6);
       total_proj_FESV1=zeros(7,1);
       for j=1:6
            ens_proj_FESV1(:,j)=((u_svd(:,j)'*F_T_IESV_online_17_no_orth')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       IESV_online_17_no_orth_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
%% orth IESV alpha
       tt3=(exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_orth_IESV_online_17=exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_orth_IESV_online_17=F_T_orth_IESV_online_17./sqrt(F_T_orth_IESV_online_17*F_T_orth_IESV_online_17');
       for j=1:7
            orth_IESV_online_17_max_pert(j,:)=exp4.ensmember{j}.record.vars{1}((i*(da_times+1)),select_local)-exp4.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       end
       [u_svd s_svd v_svd]=svd(orth_IESV_online_17_max_pert');
       s_value(i,1:7,4)=diag(s_svd);
       ens_proj_FESV1=zeros(7,6);
       total_proj_FESV1=zeros(7,1);
       for j=1:6
            ens_proj_FESV1(:,j)=((u_svd(:,j)'*F_T_orth_IESV_online_17')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       orth_IESV_online_17_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
%% ensmean alpha
       tt5=(exp5.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       F_T_neg_orth_IESV_online_17=exp5.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       F_T_neg_orth_IESV_online_17=F_T_neg_orth_IESV_online_17./sqrt(F_T_neg_orth_IESV_online_17*F_T_neg_orth_IESV_online_17');
       for j=1:7
            ensmean_online_17_no_orth_max_pert(j,:)=exp5.ensmember{j}.record.vars{1}((i*(da_times+1)),select_local)-exp5.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       end
       [u_svd s_svd v_svd]=svd(ensmean_online_17_no_orth_max_pert');
       s_value(i,1:7,5)=diag(s_svd);
       ens_proj_FESV1=zeros(7,6);
       total_proj_FESV1=zeros(7,1);
       for j=1:6
            ens_proj_FESV1(:,j)=((u_svd(:,j)'*F_T_neg_orth_IESV_online_17')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       ensmean_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
 %% orth ensmean alpha
       tt6=(exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       Orth_ensmean_online_17=exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       Orth_ensmean_online_17=Orth_ensmean_online_17./sqrt(Orth_ensmean_online_17*Orth_ensmean_online_17');
       for j=1:7
            Orth_ensmean_max_pert(j,:)=exp6.ensmember{j}.record.vars{1}((i*(da_times+1)),select_local)-exp6.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       end
       [u_svd s_svd v_svd]=svd(Orth_ensmean_max_pert');
       s_value(i,1:7,6)=diag(s_svd);
       ens_proj_FESV1=zeros(7,6);
       total_proj_FESV1=zeros(7,1);
       for j=1:6
            ens_proj_FESV1(:,j)=((u_svd(:,j)'*Orth_ensmean_online_17')).*u_svd(:,j); 
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
       end
       Orth_ensmean_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);
 %% 8_ens_orth_IESV_orth_ensmean
       tt8=(exp7.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local)).^2;
       Orth_IESV1_SVD_8ens_online_17=exp7.ensmean.record.vars{1}((i*(da_times+1)),select_local)-truth.determinist.record.vars{1}((i*(da_times-2))+1,select_local);
       Orth_IESV1_SVD_8ens_online_17=Orth_IESV1_SVD_8ens_online_17./sqrt(Orth_IESV1_SVD_8ens_online_17*Orth_IESV1_SVD_8ens_online_17');
       for j=1:8
            Orth_IESV1_ensmean_8ens_max_pert(j,:)=exp7.ensmember{j}.record.vars{1}((i*(da_times+1)),select_local)-exp7.ensmean.record.vars{1}((i*(da_times+1)),select_local);
       end
       [u_svd s_svd v_svd]=svd(Orth_IESV1_SVD_8ens_max_pert');
       s_value(i,1:7,7)=diag(s_svd);
       ens_proj_FESV1=zeros(7,7);
       total_proj_FESV1=zeros(7,1);
       for j=1:7
           if s_svd(j,j)<10^(-8)
              ens_proj_FESV1(:,j)=zeros(length(u_svd(:,1)),1);
           else
            ens_proj_FESV1(:,j)=((u_svd(:,j)'*Orth_IESV1_SVD_8ens_online_17')).*u_svd(:,j); 
            end
            total_proj_FESV1=total_proj_FESV1+ens_proj_FESV1(:,j);
           
       end
       Orth_IESV1_ensmean_8ens_max_percent(i-50,1)=sqrt(total_proj_FESV1'*total_proj_FESV1);

end

%% plot

AA1=con_max_percent;
AA2=SVD_max_percent;
AA3=IESV_online_17_no_orth_max_percent;
AA4=orth_IESV_online_17_max_percent;
AA5=ensmean_max_percent;
AA6=Orth_ensmean_max_percent;
AA7=Orth_IESV1_ensmean_8ens_max_percent;

figure;
f2(1)=plot(321:599,AA1(271:549,1),'k-','Linewidth',1.5);hold on
% f2(2)=plot(321:599,AA2(271:549,1),'color',[150 150 150]./255,'Linewidth',1.5);hold on
f2(3)=plot(321:599,AA3(271:549,1),'color',[230 0 51]./255,'Linewidth',1.5);hold on
f2(4)=plot(321:599,AA4(271:549,1),'color',[255 153 0]./255,'Linewidth',1.5);hold on
f2(5)=plot(321:599,AA5(271:549,1),'color',[0 153 51]./255,'Linewidth',1.5);hold on
% f2(6)=plot(321:599,AA6(271:549,1),'color',[102 255 0]./255,'Linewidth',1.5);hold on
% f2(7)=plot(321:599,AA7(271:549,1),'color',[0 102 204]./255,'Linewidth',1.5);hold on
% plot(321:599,AA3(271:549,1),'color',[255 0 51]./255,'Linewidth',1);hold on

xlim([320 600]);ylim([0.4 1]);
% legend([f2(1,1:7)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Ensmean','Neg. Orth IESV','SVD+Orth IESV')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,:)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Ensmean','Neg. Orth IESV','SVD+Orth IESV')%,'Observation error')%,'Orientation','horizon')%,'Location','South')
%  legend('Control run','Orth IESV','Ensmean')%,'Observation error','Orientation','horizon')%,'Location','South')
% legend([f2(1,1:10)'],'Control run','Orth vector from SVD','IESV','Orth IESV','Neg. Orth IESV','Ensmean','SVD+Orth IESV','Orth Ensmean','8 members(Orth IESV1+SVD)','7 members')%,'Orientation','horizon')%,'Location','South')
% legend([f2(1,[1 6 7 ])'],'Control run','Ensmean','Orth Ensmean','7 member');%,'Orientation','horizon')%,'Location','South')
legend([f2(1,[1 3 4 5])'],'Control run','IESV1','Orth IESV1','Neg. Orth IESV1');%,'Orientation','horizon')%,'Location','South')

legend('boxoff');
% set(hl,'Orientation','horizon');
% xlabel('DA cycle');
ylabel(' \alpha ');
set(gcf,'position',[0.2 150 2000 300]);
set(gca,'position',[0.035 0.1 0.95 0.85])
set(gca,'FontSize',16);
%% eiganvalue
mean_s = zeros(549,8,7);
for i=51:600
    for j=1:8
        s_value(i,:,j)=sqrt(s_value(i,:,j));
    end
end
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
f3(1)=plot(1:7,ss(:,1),'k-','Linewidth',1.5);hold on
f3(2)=plot(1:7,ss(:,2),'color',[150 150 150]./255,'Linewidth',2);hold on
% f3(2)=plot(1:8,ss(:,5),'color',[0 102 204]./255,'Linewidth',1.5);hold on
f3(4)=plot(1:7,ss(:,4),'color',[255 153 0]./255,'Linewidth',2);hold on
% f3(3)=plot(1:8,ss(:,3),'color',[255 0 51]./255,'Linewidth',1);hold on
% f3(4)=plot(1:7,ss(:,4),'color',[255 153 0]./255,'Linewidth',1);hold on

% f3(5)=plot(1:7,ss(:,5),'color',[204 0 204]./255,'Linewidth',1);hold on
f3(6)=plot(1:7,ss(:,6),'color',[102 255 0]./255,'Linewidth',2);hold on
f3(7)=plot(1:7,ss(:,7),'color',[0 102 204]./255,'Linewidth',2);hold on
% f3(7)=plot(1:7,ss(:,7),'color',[0 255 0]./255,'Linewidth',1.5);hold on
% plot(321:599,AA3(271:549,1),'color',[255 0 51]./255,
% 'Linewidth',1);hold on
legend([f3(1,[1 2 4 6 7])'],'Control run','Orth vector from SVD','Orth IESV','Orth Ensmean', '8 member(Orth IESV1+orth ensmean)')%,'Orientation','horizon')%,'Location','South')
% legend([f3(1,[1 2 4 7])'],'Control run','Orth vector from SVD','Orth IESV','Orth Ensmean')%,'Orientation','horizon')%,'Location','South')
legend('boxoff');
xlabel('mode');
ylabel('mean eigenvalue (%)');
set(gca,'FontSize',16);
xlim([1 7]);
% ylabel('mean eigenvalue value(%) (compare to control run) ');
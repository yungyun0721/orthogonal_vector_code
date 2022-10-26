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
%% whole domain 1std~2std & >2std
con_std=std(control_rmse(:,2),0,1);
con_mean=mean(control_rmse(:,2));
k=1;
w=1;
clear large_time large2_time
for i=51:599
    if control_rmse(i-50,2)>=con_mean+con_std && control_rmse(i-50,2)<=con_mean+con_std*2
        large_time(k,1)=i-50;
        k=k+1;
    end
    if control_rmse(i-50,2)>=con_mean+con_std*2 
        large2_time(w,1)=i-50;
        w=w+1;
    end
end

%% RUN offline orth_svd
% load('da2_run_offline_SVD');
% da2_offline_run=da2_run_offline_SVD;
load('da2_run_offline_svd_rand_18');
da2_offline_run=da2_run_offline_svd_rand_18;
da2_offline_run = select_refresh_ensmean(da2_offline_run,1:7);
% load('da2_run_SVD_online_17');
% da2_online_run=da2_run_SVD_online_17;
load('da2_run_online_svd_rand_18');
da2_online_run=da2_run_online_svd_rand_18;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_offline_orth_svd(i-50,2:32)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_offline_orth_svd(i-50,1)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));
    da22_forecast_online_orth_svd(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_orth_svd(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% run offline  IESV
load('da2_run_offline_IESV')
da2_offline_run=da2_run_offline_IESV;
da2_offline_run = select_refresh_ensmean(da2_offline_run,1:7);
load('da2_run_IESV_online_17_no_orth');
da2_online_run=da2_run_IESV_online_17_no_orth;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_offline_IESV(i-50,2:32)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_offline_IESV(i-50,1)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));
    da22_forecast_online_IESV(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_IESV(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% run offline  orth_IESV
load('da2_run_offline_orth_IESV')
da2_offline_run=da2_run_offline_orth_IESV;
da2_offline_run = select_refresh_ensmean(da2_offline_run,1:7);
load('da2_run_orth_IESV_online_17');
da2_online_run=da2_run_orth_IESV_online_17;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_offline_orth_IESV(i-50,2:32)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_offline_orth_IESV(i-50,1)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));
    da22_forecast_online_orth_IESV(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_orth_IESV(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% run offline  ensmean
load('da2_run_offline_ensmean')
da2_offline_run=da2_run_offline_ensmean;
da2_offline_run = select_refresh_ensmean(da2_offline_run,1:7);
load('da2_run_ensmean_online_17_no_orth');
da2_online_run=da2_run_ensmean_online_17_no_orth;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_offline_ensmean(i-50,2:32)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_offline_ensmean(i-50,1)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));
    da22_forecast_online_ensmean(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_ensmean(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%% run offline  orth_ensmean
load('da2_run_offline_orth_ensmean')
da2_offline_run=da2_run_offline_orth_ensmean;
da2_offline_run = select_refresh_ensmean(da2_offline_run,1:7);
load('da2_run_orth_ensmean_online_18');
da2_online_run=da2_run_orth_ensmean_online_18;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_offline_orth_ensmean(i-50,2:32)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_offline_orth_ensmean(i-50,1)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));
    da22_forecast_online_orth_ensmean(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_orth_ensmean(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%%
load('da2_run_offline_8_ens_orth_IESV_orth_ensmean')
da2_offline_run=da2_run_offline_8_ens_orth_IESV_orth_ensmean;
da2_offline_run = select_refresh_ensmean(da2_offline_run,1:8);
load('da2_run_online_8_ens_orth_IESV_orth_ensmean_inf_19');
da2_online_run=da2_run_online_8_ens_orth_IESV_orth_ensmean_inf_19;
da2_online_run = select_refresh_ensmean(da2_online_run,1:6);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_offline_8_ens_orth_IESV_orth_ensmean(i-50,2:32)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_offline_8_ens_orth_IESV_orth_ensmean(i-50,1)=sqrt(mean((da2_offline_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));
    da22_forecast_online_8_ens_orth_IESV_orth_ensmean(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_8_ens_orth_IESV_orth_ensmean(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end
%%

load('da2_run_7_ens_18');
da2_online_run=da2_run_7_ens_18;
da2_online_run = select_refresh_ensmean(da2_online_run,1:7);
for i=51:599
    da_times=32;
    tt_times=(i*da_times):((i+1)*da_times);
    tt_for_times=(i*(da_times+1)+1):((i+1)*(da_times+1)-2);
    tt_for_times1=(i*(da_times)+1):((i+1)*(da_times)-1);
    truth_for_times=(i*(da_times-2))+1:((i+1)*(da_times-2))+1;
    da22_forecast_online_7_ens(i-50,2:32)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(tt_for_times,:)-truth.determinist.record.vars{1}(truth_for_times,:)).^2,2));
    da22_forecast_online_7_ens(i-50,1)=sqrt(mean((da2_online_run.ensmean.record.vars{1}(i*(da_times+1),:)-truth.determinist.record.vars{1}((i*(da_times-2))+1,:)).^2,2));

end

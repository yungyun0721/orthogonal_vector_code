%% load libraries
% sprout.initializer(2)

%% clear
clear all
close all

%% initial
[model_settings, obs_settings, da_settings] = settings(); 
[truth, DetInitial, EnsInitial, observation, NEItemp] = NormalExperimentInitializer(model_settings, obs_settings,18000);

% model_settings.ensemble.members = 8;
model_settings.ensemble.members = 7;
[model2_settings, obs2_settings, da2_settings] = settings(); 
[truth2, DetInitial2, EnsInitial2, observation2, NEItemp1] = NormalExperimentInitializer(model_settings, obs_settings,18000);

%% Data Assimilation
disp('state : data assimilation')
fr_run = DetInitial;
VAR_run = DetInitial;
da_run = EnsInitial;
da2_run = EnsInitial2;
da_times = length(observation.all_observation_time);
% observation.variance{1}=1;
material = letkf.preinitializer(da_settings, da_run, observation);
material2 = letkf.preinitializer(da2_settings, da2_run, observation2);
disp_gate = round((0:0.1:1).*da_times);
xb_initial = metrix_ensemble(da_run,1:6);% first time step
% 
% rng(31)
% rand_obs = randn(da_times,1);
% observation.variance{1}=0;
 load('test_B3DVar2.mat');
 control_da_run=da_run;
 no_da_run=da_run;
 fsteps=30;
for times=1:da_times
    if (sum(disp_gate==(times-1))>0)
        disp([num2str(times-1),'/',num2str(da_times)])
    end
    
%     [fsteps, next_obs_time] = find_next_obs_time(observation.all_observation_time, da_run.time, da_run);
    [control_fsteps, control_next_obs_time] = find_next_obs_time(observation.all_observation_time, control_da_run.time, control_da_run);
    fr_run = fr_run.integrate(fsteps);
%     fr_run.determinist = fr_run.determinist.add_record;
    control_da_run = control_da_run.gathered_integrate(control_fsteps);
    da2_run=da2_run.gathered_integrate(control_fsteps);
    da_run = da_run.gathered_integrate(control_fsteps);
    da_run = da_run.add_record('forecast');
    da2_run = da2_run.add_record('forecast');
    
    no_da_run = no_da_run.gathered_integrate(fsteps);
    control_da_run = control_da_run.add_record('forecast');
    no_da_run=no_da_run.add_record('forecast');
    
     %% calculate ESV EV
    xb_final = metrix_ensemble(control_da_run,1:6);
    [IESV, FESV, ESV_S, all_FESV,all_IESV,energy_initial,energy_final] = esv(xb_initial,xb_final,1);
%     [IESV_old, FESV_old, ESV_S_old, all_FESV_old,energy_initial_old,energy_final_old] = esv_old(xb_initial,xb_final,1);
    [EV1, EV_S ,all_EV] = ev(xb_final,1);
    [SVD_EV,SVD_EV_S,SVD_V]=svd(xb_final,0);
    %% no da+da
    if times>50
        no_xb_final=metrix_ensemble(no_da_run,ii);
        [initial_nn,final_nn,more_IESV, more_FESV, more_ESV_S, more_all_FESV, more_all_IESV, more_energy_initial, more_energy_final]...
            = more_esv(xb_initial,no_xb_initial,xb_final,no_xb_final,1);
    end
    %%
      spr_xb_final=mean(std(xb_final,0,2));
      growing_error=mean(xb_final,2)-truth.determinist.record.vars{1}(fsteps*times+1,:)';
      growing_error=growing_error/sqrt(growing_error'*growing_error);
      
      proj_FESV1=FESV-(FESV'*EV1/(EV1'*EV1)).*EV1;
%     analysis = ensemble_analysis( da_run,observation,da_settings,da_run.time,material);
%     da_run = da_run.update_ensemble(analysis);
%     da_run = da_run.add_record('analysis');
    
%     analysis2 = ensemble_analysis( da2_run,observation,da2_settings,da2_run.time,material2);
%     da2_run = da2_run.update_ensemble(analysis2);
%      da2_run = da2_run.add_record('analysis');
    
    control_analysis = ensemble_analysis(control_da_run,observation,da_settings,control_da_run.time,material);
    control_da_run = control_da_run.update_ensemble(control_analysis);
    control_da_run = control_da_run.add_record('analysis');
    xb_initial = metrix_ensemble(control_da_run,1:6);
    
    %%
    select_localization=3;
    [c,k]=max(abs(growing_error));
    select_local=mod(k-select_localization:k+select_localization,40);
       for i= 1:2*select_localization+1
           if select_local(1,i)==0
               select_local(1,i)=40;
           end
       end

       xb_final_pert = bsxfun(@minus,xb_final,mean(xb_final,2));
       [ub sb vb]=svd(xb_final_pert(select_local,:));
       [u s v]=svd(xb_final_pert);
       gg=u(select_local,6);
       find_u_6=(u(select_local,6:40))'*gg./sqrt(diag(u(select_local,6:40)'*u(select_local,6:40)))./sqrt(gg'*gg);
       [c1,k1]=max(abs(find_u_6));
       k1=k1+5;
%        k1=10;
       k1=18;
%% add new vector (vectical)
     cc=all_IESV(:,1);
%      cc=mean(xb_final,2);
     cc=cc/sqrt(cc'*cc);
     vv=zeros(40,1);
    for j=1:5
        ens_proj_FESV1(:,j)=((u(:,j)'*cc)).*u(:,j); 
        vv=vv+ens_proj_FESV1(:,j);
    end
    vect=cc-vv;
    vect=vect/sqrt(vect'*vect);
    
%% 
    if times>49
%         spr_xb_initial=mean(std(xb_initial,0,2));   
%          plus_new_vector=vect.*(-1);
%      if (vect'*u(:,k1))>0
%          plus_new_vector=vect+u(:,k1);
%      else
%          plus_new_vector=vect-u(:,k1);
%      end
%         plus_new_vector=cc;
        plus_new_vector=u(:,k1);
%         plus_new_vector=vect;
       plus_new_vector=plus_new_vector/sqrt(plus_new_vector'*plus_new_vector);
        
        spr_xb_final=mean(std(xb_final,0,2));  
        for i=1:6
%         da2_run.ensmember{i}.vars{1}=da_run.ensmember{i}.vars{1}-spr_xb_initial.*u(:,k1)'/sqrt(42);
        da2_run.ensmember{i}.vars{1}=da_run.ensmember{i}.vars{1}-spr_xb_final.*plus_new_vector'/sqrt(42);
        end
%         da2_run.ensmember{7}.vars{1}=(mean(xb_initial(:,1:6),2)-spr_xb_initial.*u(:,k1))';
        da2_run.ensmember{7}.vars{1}=(mean(xb_final(:,1:6),2)+spr_xb_final.*plus_new_vector*6./sqrt(42))';
%         da2_run.ensmember{8}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,k1))';
    end
%         da2_run = da2_run.add_record('analysis');
     da2_run = da2_run.add_record('change');
     analysis2 = ensemble_analysis( da2_run,observation,da2_settings,da2_run.time,material2);
     da2_run = da2_run.update_ensemble(analysis2);
     da2_run = da2_run.add_record('analysis');
     
      analysis = ensemble_analysis( da_run,observation,da_settings,da_run.time,material);
    da_run = da_run.update_ensemble(analysis);
    da_run = da_run.add_record('analysis');
    
%     if times>49
%         [u s v]=svd(xb_initial);
%         spr_xb_initial=mean(std(xb_initial,0,2));   
%         da2_run.ensmember{7}.vars{1}=(mean(xb_initial(:,1:6),2)-spr_xb_initial.*u(:,6))';
%         da2_run.ensmember{8}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,6))';
%     end
        %% doing no da ensemble
    
if times>49
    [u s v]=svd(xb_initial);
    spr_xb_initial=mean(std(xb_initial,0,2));
%     more_ens_mean=sum(u(:,6:7),2);
%     u(:,7:12)=bsxfun(@minus,u(:,7:12),more_ens_mean);
    no_da_run.ensmember{1}.vars{1}=(mean(xb_initial(:,1:6),2)-spr_xb_initial.*u(:,6))';
%     no_da_run.ensmember{2}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,8))';
%     no_da_run.ensmember{3}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,9))';
%     no_da_run.ensmember{4}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,10))';
    no_da_run.ensmember{5}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,6))';
%     no_da_run.ensmember{6}.vars{1}=(mean(xb_initial(:,1:6),2)-spr_xb_initial.*more_ens_mean)';
    ii=[1 5];
    no_xb_initial=metrix_ensemble(no_da_run,ii);
end
    no_da_run = no_da_run.add_record('change');
%% removing the FESV1
%     if times>50
% select_localization=3;
% [c,k]=max(abs(growing_error));
%     select_local=mod(k-select_localization:k+select_localization,40);
%        for i= 1:2*select_localization+1
%            if select_local(1,i)==0
%                select_local(1,i)=40;
%            end
%        end
% %%
% xb_mean=mean(xb_initial,2);
% T=truth.determinist.record.vars{1}(fsteps*times+1,:)';
% A_T=xb_mean-T;
% fix_proj_FESV1(1:(select_localization*2+1),1)=((FESV(select_local(1,:),1)'*A_T(select_local(1,:),1)./sum(FESV(select_local(1,:),1).^2))*FESV(select_local(1,:),1));
% 
% for i=1:model_settings.ensemble.members
%    da_run.ensmember{i}.vars{1}=control_da_run.ensmember{i}.vars{1};
%    da_run.ensmember{i}.vars{1}(1,select_local(1,:))=control_da_run.ensmember{i}.vars{1}(1,select_local(1,:))-fix_proj_FESV1';
% end
% cc=metrix_ensemble(da_run);
% hh(times,1)=sqrt(mean((mean(cc,2)-T).^2));
% % disp([num2str(times)]);
% 
%     end
%     da_run = da_run.add_record('analysis');
    %%
   %da_run = da_run_resampling(da_run);
    
      
    
%     da_run=da_run_select_recenter(da_run,xb_initial,1:10);
    
%     da_run.ensmember{13}.vars{1}=(mean(xb_initial,2)+mean(std(xb_final,0,2))/std(EV1).*EV1)';
%     da_run.ensmember{14}.vars{1}=(mean(xb_initial,2)-mean(std(xb_final,0,2))/std(EV1).*EV1)';

%     xb_initial = metrix_ensemble(da_run);
    %% calculate theta S
% %       
     total(times).ESV_S   = diag(ESV_S)';
     total(times).EV_S    = diag(EV_S)';
     total(times).FESV    = all_FESV;
     total(times).IESV    = all_IESV;
     if times>50
     total(times).more_ESV_S   = diag(more_ESV_S)';
     total(times).more_FESV    = more_all_FESV;
     total(times).more_IESV    = more_all_IESV;
     total(times).more_initial = more_energy_initial;
     total(times).more_final   = more_energy_final;
     total(times).more_initial_nn = initial_nn;
     total(times).more_final_nn   = final_nn;
     total(times).vect   = vect;
     total(times).svd_u = u;
     total(times).svd_v = v;
     total(times).svd_s = s;
     

     end
     total(times).EV      = all_EV;
     total(times).SVD_EV      = SVD_EV;
     total(times).SVD_EV_S      = SVD_EV_S;
     total(times).energy_initial = energy_initial;
     total(times).energy_final   = energy_final;

end
disp('state : data assimilation finished')
%%
  da_run = da_run.refresh_ensmean;
 control_da_run = control_da_run.refresh_ensmean;
%  no_da_run = no_da_run.refresh_ensmean;
%   da_run = select_refresh_ensmean(da_run,1:6);
  da2_run = select_refresh_ensmean(da2_run,1:6);
%% judgement/diagnose
lorenz96_RMSE_plotter(truth, fr_run, control_da_run);
lorenz96_RMSE_plotter(truth, fr_run, da_run);
lorenz96_RMSE_plotter(truth2, fr_run, da2_run);
%%
control_da_run_rmse = diagnose.all_time_rmse(truth,control_da_run);
control_da_run_es = diagnose.all_time_es(control_da_run);
control_ens_rmse=control_da_run_rmse.vars{1}();
control_ens_es=control_da_run_es.mean.vars{1}();
da_run_rmse = diagnose.all_time_rmse(truth,da_run);
da_run_es = diagnose.all_time_es(da_run);
ens_rmse=da_run_rmse.vars{1}();
ens_es=da_run_es.mean.vars{1}();
da2_run_rmse = diagnose.all_time_rmse(truth,da2_run);
da2_run_es = diagnose.all_time_es(da2_run);
ens2_rmse=da_run_rmse.vars{1}();
ens2_es=da_run_es.mean.vars{1}();
for i=1:times
    control_da_rmse(i,1)=control_ens_rmse(1+(fsteps+2)*i,1);
    control_bb_rmse(i,1)=control_ens_rmse((fsteps+2)*i,1);
    control_da_es(i,1)=control_ens_es(1+(fsteps+2)*i,1);
    control_bb_es(i,1)=control_ens_es((fsteps+2)*i,1);
end
for i=1:times
%     rm_da_rmse(i,1)=ens_rmse(1+(fsteps+2)*i,1);
    da_rmse(i,1)=ens_rmse(1+(fsteps+2)*i,1);
    bb_rmse(i,1)=ens_rmse((fsteps+2)*i,1);
%     rm_da_es(i,1)=ens_es(1+(fsteps+2)*i,1);
    da_es(i,1)=ens_es(1+(fsteps+2)*i,1);
    bb_es(i,1)=ens_es((fsteps+2)*i,1);
end

for i=1:times
%     rm_da2_rmse(i,1)=ens2_rmse(1+(fsteps+2)*i,1);
    da2_rmse(i,1)=ens2_rmse((fsteps+2)*i+1,1);
    bb2_rmse(i,1)=ens2_rmse((fsteps+2)*i,1);
%     rm_da2_es(i,1)=ens2_es(1+(fsteps+2)*i,1);
    da2_es(i,1)=ens2_es((fsteps+2)*i+1,1);
    bb2_es(i,1)=ens2_es((fsteps+2)*i,1);
end
% % lorenz96_bar_plotter(total_compare,1);
% lorenz96_bar_plotter(total_compare,2);
% lorenz96_bar_plotter(total_compare,10);
% lorenz96_bar_plotter(total_compare,11);
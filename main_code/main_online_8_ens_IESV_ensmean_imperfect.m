%% load libraries
% sprout.initializer(2)

%% clear
clear all
close all

%% initial
load('start_truth.mat')
load('start_observation.mat')
[model_settings, obs_settings, da_settings] = settings_imperfect(); 
[truth, DetInitial, EnsInitial, observation, NEItemp] = NormalExperimentInitializer(model_settings, obs_settings,18000);

model_settings.ensemble.members = 8;
% model_settings.ensemble.members = 7;
[model2_settings, obs2_settings, da2_settings] = settings_imperfect(); 
[truth2, DetInitial2, EnsInitial2, observation2, NEItemp1] = NormalExperimentInitializer(model_settings, obs_settings,18000);
truth=start_truth;
observation = start_observation
%% Data Assimilation
disp('state : data assimilation')
fr_run = DetInitial;
VAR_run = DetInitial;
da_run = EnsInitial;
da2_run = EnsInitial2;
da_times = length(observation.all_observation_time);
% observation.variance{1}=1;
material = letkf.preinitializer(da_settings, da_run, observation);
da2_settings.etkf.analyzer.mci_factor = 2.5;
material2 = letkf.preinitializer(da2_settings, da2_run, observation2);
disp_gate = round((0:0.1:1).*da_times);
xb_initial = metrix_ensemble(da_run,1:6);% first time step
xb2_initial=metrix_ensemble(da2_run,1:6);
% 
% rng(31)
% rand_obs = randn(da_times,1);
% observation.variance{1}=0;
 load('test_B3DVar2.mat');
 control_da_run=da_run;
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
    

    control_da_run = control_da_run.add_record('forecast');

    
     %% calculate ESV EV
    xb_final = metrix_ensemble(control_da_run,1:6);
    xb2_final=metrix_ensemble(da2_run,1:6);
    [IESV, FESV, ESV_S, all_FESV,all_IESV,energy_initial,energy_final] = esv(xb_initial,xb_final,1);
    [IESV2, FESV2, ESV2_S, all2_FESV,all2_IESV,energy2_initial,energy2_final] = esv(xb2_initial,xb2_final,1);
    [EV1, EV_S ,all_EV] = ev(xb_final,1);
    [SVD_EV,SVD_EV_S,SVD_V]=svd(xb_final,0);
    %% no da+da
%     if times>50
%         no_xb_final=metrix_ensemble(no_da_run,ii);
%         [initial_nn,final_nn,more_IESV, more_FESV, more_ESV_S, more_all_FESV, more_all_IESV, more_energy_initial, more_energy_final]...
%             = more_esv(xb_initial,no_xb_initial,xb_final,no_xb_final,1);
%     end
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
 
     if times>49 %&& mod(times,4)==0    
            
         if times==50
            for i=1:6
            da2_run.ensmember{i}.vars{1}=control_da_run.ensmember{i}.vars{1};
            end
            all2_IESV(:,1:6)=all_IESV;
         end
   

   %% making the orthogonal vector
     xb_ch_mean =metrix_ensemble(da2_run,1:6);
     select_localization=3;
     growing_error=mean(xb_ch_mean,2)-truth.determinist.record.vars{1}(fsteps*times+1,:)';
     growing_error=growing_error/sqrt(growing_error'*growing_error);
    [c,k]=max(abs(growing_error));
    select_local=mod(k-select_localization:k+select_localization,40);
       for i= 1:2*select_localization+1
           if select_local(1,i)==0
               select_local(1,i)=40;
           end
       end

       xb_ch_final_pert = bsxfun(@minus,xb_ch_mean,mean(xb_ch_mean,2));
       [ub sb vb]=svd(xb_ch_final_pert(select_local,:));
       [u s v]=svd(xb_ch_final_pert);
       gg=u(select_local,7);
       find_u_6=(u(select_local,6:40))'*gg./sqrt(diag(u(select_local,6:40)'*u(select_local,6:40)))./sqrt(gg'*gg);
       [c1,k1]=max(abs(find_u_6));
       k1=k1+5;
       %% add new vector (vectical)(IESV1)
%      cc=all2_IESV(:,1);
     cc=mean(xb_ch_mean,2);
     cc=cc/sqrt(cc'*cc);
     vv=zeros(40,1);
    for j=1:5
        ens_proj_FESV1(:,j)=((u(:,j)'*cc)).*u(:,j); 
        vv=vv+ens_proj_FESV1(:,j);
    end
    vect=cc-vv;
    vect=vect/sqrt(vect'*vect);      
    %% add new vector (vectical)(Ensmean)
     cc2=all2_IESV(:,1);
%      cc2=mean(xb_ch_mean,2);
     cc2=cc2/sqrt(cc2'*cc2);
     vv2=zeros(40,1);
    for j=1:5
        ens_proj_FESV1(:,j)=((u(:,j)'*cc2)).*u(:,j); 
        vv2=vv2+ens_proj_FESV1(:,j);
    end
    vect2=cc2-vv2;
    vect2=vect2/sqrt(vect2'*vect2);
   
   
   
%%   add orthogonal vector

%         spr_xb_initial=mean(std(xb_initial,0,2));   
%         plus_new_vector=u(:,k1);
        plus_new_vector=vect;
%      if vect'*u(:,k1)>0
%          plus_new_vector=vect+u(:,k1);
%      else
%          plus_new_vector=vect-u(:,k1);
%      end     
%      if mod(times,2)==0
%          plus_new_vector=vect*(-1);
%      else
%          plus_new_vector=vect;
%      end
%         plus_new_vector=cc*(-1);%+u(:,k1);
%         plus_new_vector=plus_new_vector/sqrt(plus_new_vector'*plus_new_vector);
        spr_xb_final=mean(std(xb_ch_mean,0,2));
        plus_new_vector1=vect;
%         plus_new_vector2=u(:,k1)-(u(:,k1)'*vect).*vect;
        plus_new_vector2=vect2-(vect2'*vect).*vect;
       
%         if vect'*u(:,k1)>0
          if vect'*vect2>0
%             plus_new_vector2=u(:,k1);
              plus_new_vector2=plus_new_vector2;
        else
%             plus_new_vector2=(-1)*u(:,k1);
              plus_new_vector2=(-1)*plus_new_vector2;
        end
         plus_new_vector2=plus_new_vector2./sqrt(plus_new_vector2'*plus_new_vector2);
        
        
       for i=1:6
%         da2_run.ensmember{i}.vars{1}=da_run.ensmember{i}.vars{1}-spr_xb_initial.*u(:,k1)'/sqrt(42);
        da2_run.ensmember{i}.vars{1}=da2_run.ensmember{i}.vars{1}-spr_xb_final.*plus_new_vector1'/sqrt(42)-spr_xb_final.*plus_new_vector2'/sqrt(56);
        end
%         da2_run.ensmember{7}.vars{1}=(mean(xb_initial(:,1:6),2)-spr_xb_initial.*u(:,k1))';
        da2_run.ensmember{7}.vars{1}=(mean(xb_ch_mean,2)+spr_xb_final.*plus_new_vector1*6./sqrt(42))'-spr_xb_final.*plus_new_vector2'/sqrt(56);
        da2_run.ensmember{8}.vars{1}=(mean(xb_ch_mean,2)+spr_xb_final.*plus_new_vector2*7./sqrt(56))';
%         da2_run.ensmember{8}.vars{1}=(mean(xb_initial(:,1:6),2)+spr_xb_initial.*u(:,k1))';
  
   
    
     end

    control_analysis = ensemble_analysis(control_da_run,observation,da_settings,control_da_run.time,material);
    control_da_run = control_da_run.update_ensemble(control_analysis);
    control_da_run = control_da_run.add_record('analysis');
    xb_initial = metrix_ensemble(control_da_run,1:6);
    

     da2_run = da2_run.add_record('change');
     analysis2 = ensemble_analysis( da2_run,observation,da2_settings,da2_run.time,material2);
     da2_run = da2_run.update_ensemble(analysis2);
   
    
          
    analysis = ensemble_analysis( da_run,observation,da_settings,da_run.time,material);
    da_run = da_run.update_ensemble(analysis);
    da_run = da_run.add_record('analysis');
     
     
         %% 7choose 6
    if times>49
%    romove_ens=randperm(7,1);
%    choose_i=setxor(1:7,romove_ens);
   choose_i=[1 2 3 4 5 6];
   ens7_aj_mean =mean(metrix_ensemble(da2_run,1:8),2);
   ens7_aj_pert =bsxfun(@minus,metrix_ensemble(da2_run,1:8),ens7_aj_mean);
   ens6_re_aj_pert =bsxfun(@minus,ens7_aj_pert(1:40,choose_i),mean(ens7_aj_pert(1:40,choose_i),2)).*mean(std(ens7_aj_pert,0,2))./mean(std(ens7_aj_pert(1:40,choose_i),0,2));
    for i=1:6
%         da2_run.ensmember{i}.vars{1}=da_run.ensmember{i}.vars{1}-spr_xb_initial.*u(:,k1)'/sqrt(42);
       da2_run.ensmember{i}.vars{1}=(ens7_aj_mean+ens6_re_aj_pert(:,i))';
     end
   end
    xb2_initial=metrix_ensemble(da2_run,1:6);

  da2_run = da2_run.add_record('analysis');


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
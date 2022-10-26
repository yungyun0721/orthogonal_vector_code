%% load libraries
% sprout.initializer

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
da2_settings.etkf.analyzer.mci_factor = 1.8;
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


    %%

     if times==50 
   %% making the orthogonal vector
      xb_ch_mean =metrix_ensemble(control_da_run,1:6);
      xb_ch_final_pert = bsxfun(@minus,xb_ch_mean,mean(xb_ch_mean,2));
      [u s v]=svd(xb_ch_final_pert);
      plus_new_vector=u(:,7);
%%   add orthogonal vector
        spr_xb_final=mean(std(xb_ch_mean,0,2));  
        for i=1:6
            da2_run.ensmember{i}.vars{1}=da2_run.ensmember{i}.vars{1}-spr_xb_final.*plus_new_vector'./sqrt(42);
        end
        
         da2_run.ensmember{7}.vars{1}=(mean(xb_ch_mean,2)+spr_xb_final.*plus_new_vector*6./sqrt(42))';
    end
%         da2_run = da2_run.add_record('analysis');
    control_analysis = ensemble_analysis(control_da_run,observation,da_settings,control_da_run.time,material);
    control_da_run = control_da_run.update_ensemble(control_analysis);
    control_da_run = control_da_run.add_record('analysis');
    xb_initial = metrix_ensemble(control_da_run,1:6);
    

     da2_run = da2_run.add_record('change');
     analysis2 = ensemble_analysis( da2_run,observation,da2_settings,da2_run.time,material2);
     da2_run = da2_run.update_ensemble(analysis2);
     da2_run = da2_run.add_record('analysis');
    
          
    analysis = ensemble_analysis( da_run,observation,da_settings,da_run.time,material);
    da_run = da_run.update_ensemble(analysis);
    da_run = da_run.add_record('analysis');


end
disp('state : data assimilation finished')
%%
  da_run = da_run.refresh_ensmean;
 control_da_run = control_da_run.refresh_ensmean;
%  no_da_run = no_da_run.refresh_ensmean;
%   da_run = select_refresh_ensmean(da_run,1:6);
  da2_run = select_refresh_ensmean(da2_run,1:7);
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
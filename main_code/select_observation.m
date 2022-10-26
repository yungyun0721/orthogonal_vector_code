%% select observation in to stable or unstable space

% localization=10;
% growing_error=FESV;
% select_point=0.6;

function [unstable_obs_all, stable_obs,index, local_obs_all,unstable_obs]=select_observation(observation,obs_time,localization,growing_error,select_point,observable)

% obs_time=3;
%  localization=5;
%  growing_error=FESV;
%  select_point=0.6;
run_times= 40/(4*localization);
obs(1,:)=1:40;
obs(2,:)=observation.record.vars{1}(obs_time,:);

grow_err =growing_error';
total_obs(1,1:40)=1:40;
total_obs(1,41:80)=1:40;
total_obs(1,81:120)=1:40;
k=1;
t=1;
% select_local
% while k<run_times+1
while k<observable+1
[c,index(k)]=max(abs(grow_err));
    select_local(1:2*localization+1)=total_obs(40+index(k)-localization:40+index(k)+localization);
    no_select_local(1:4*localization+1)=total_obs(40+index(k)-2*localization:40+index(k)+2*localization);
% if index < (localization+1)
%     select_local(1:index+localization)=1:index+localization;
%     select_local(index+localization+1:2*localization+1)=41-index:40;
% elseif   index > (40-localization)
%     select_local(1:localization+index-40)=1:localization+index-40;
%     select_local(localization+index-40:2*localization+1)=index-localization:40;
% else
%     select_local= Index-localization : Index+localization;
% end

%select_obs 
tt=1;
xb=growing_error(index(k),1);
for i=1:2*localization+1
    xo=growing_error(select_local(1,i),1);
%     if abs(xo/xb)>select_point
        if (xo/xb)>=select_point
        unstable_obs_all(1,t)=select_local(1,i);
        unstable_obs_all(2,t)=obs(2,select_local(1,i));
        local_obs_all(t,:)=select_local;
        unstable_obs(k).index(1,tt)=select_local(1,i);
        t=t+1;
        tt=tt+1;
    end
end
 unstable_obs(k).local_xb=select_local;
for j=1:4*localization+1
        grow_err(1,no_select_local(j))=0;
end
k=k+1;
end

    stable_obs(1,:)=setxor(1:40,unstable_obs_all(1,:));
    stable_obs(2,:)=obs(2,stable_obs(1,:));
end

    
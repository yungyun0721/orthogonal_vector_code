%% select observation in to stable or unstable space observation 1:n:40

% localization=10;
% growing_error=FESV;
% select_point=0.6;

function [unstable_obs_all, stable_obs,index, local_obs_all,unstable_obs]=select_diff_observation(observation,obs_time,localization,growing_error,select_point,observable)

 %% test
% obs_time=times;
% localization=unstable_area_long;
% growing_error=growing_error;
% select_point=0.8;
% observable=3;
%%
obs(1,:)=observation.settings.vars{1}.space.gridpoint;
obs(2,:)=observation.record.vars{1}(obs_time,:);

grow_err =growing_error';

k=1;
t=1;
% select_local
% while k<run_times+1
while k<observable+1
[c,index(k)]=max(abs(grow_err));
    select_local=mod(index(k)-localization:index(k)+localization,40);
    if localization>0
       for i= 1:2*localization+1
           if select_local(1,i)==0
               select_local(1,i)=40;
           end
       end
    end
    no_select_local=mod(index(k)-2*localization:index(k)+2*localization,40);
    if localization>0
       for i= 1:4*localization+1
           if  no_select_local(1,i)==0
                no_select_local(1,i)=40;
           end
       end
    end
   
%select_obs 
tt=1;
xb=growing_error(index(k),1);
unstable_area_observation_point=intersect(select_local,obs(1,:));
if length(unstable_area_observation_point)>0
    for i=1:length(unstable_area_observation_point)
        xo=growing_error(unstable_area_observation_point(1,i),1);
%     if abs(xo/xb)>select_point
        if (xo/xb)>=select_point
        unstable_obs_all(1,t)=unstable_area_observation_point(1,i);
        for cc=1:length(obs(1,:))
            if obs(1,cc)==unstable_area_observation_point(1,i)
                unstable_area_observation_point_transfer=cc;
            end            
        end
        unstable_obs_all(2,t)=obs(2,unstable_area_observation_point_transfer);
        local_obs_all(t,:)=select_local;   
        unstable_obs(k).index(1,tt)=unstable_area_observation_point(1,i);
        t=t+1;
        tt=tt+1;
        end
    end
end
 unstable_obs(k).local_xb=select_local;
for j=1:4*localization+1
        grow_err(1,no_select_local(j))=0;
end
k=k+1;
end
if ~exist('unstable_obs_all','var')
    unstable_obs_all=zeros(1,1);
    clear unstable_obs local_obs_all 
    unstable_obs=zeros(1,1);
    local_obs_all =zeros(1,1);
   stable_obs(1,:)=observation.settings.vars{1}.space.gridpoint;   
else
    stable_obs(1,:)=setxor(observation.settings.vars{1}.space.gridpoint,unstable_obs_all(1,:));
end
    for i=1:length(stable_obs(1,:))
        for j= 1:length(obs(1,:))
            if stable_obs(1,i)==obs(1,j)
                stable_obs(2,i)=obs(2,j);
            end
        end
    end

end

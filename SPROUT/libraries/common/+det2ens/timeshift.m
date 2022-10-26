%% ensmember = det2ens.timeshift(settings,det_model);
%
% create ensemble by combining different time state from a determinist model record

%%
function ensmember=timeshift(settings,det_model)
    % initialization
    K = settings.ensemble.members;
    shift_steps = settings.ensemble.det2ens.timeshift.steps;
    ensmember = cell(1,K);
    
    % erase old record
    endindex = det_model.determinist.record.num;
    startindex = endindex-shift_steps+1;
    det_model.determinist = det_model.determinist.erase_record(startindex,endindex);
    
    % change to old vars at start time
    det_model.determinist.time = det_model.determinist.record.time(det_model.determinist.record.num);
    det_model.time = det_model.determinist.time;
    temp = det_model.art_background(det_model.time);
    det_model.determinist.vars = temp.vars;

    % integrate with suitable time step size
    det_model.settings.integrator.step_size = 2*shift_steps*det_model.settings.integrator.step_size/(K-1);
    det_model = det_model.integrate(K-1);

    % get the wantted period
    endindex = det_model.determinist.record.num;
    startindex = endindex-K+1;
    select_time = det_model.determinist.record.time(startindex:endindex);

    % pick-up as ensemble members
    for ens=1:K
        ensmember{ens} = det_model.art_background(select_time(ens));
    end
end
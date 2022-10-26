%% dynamic_obj = integrator(dynamic_obj,settings,steps,da_package);
% 
% It is designed for class_model and work on class_dynamic
% it use the tendency equation in class_dynamic to do temporal integration
% 
% << args >>
% dynamic_obj: a class_dynamic object
% settings   : the property of class_model object
% cit        : switch for "correct in tendency"
% ct         : corrective tendency  

%%
function dynamic_obj=integrator(dynamic_obj,settings,cit,ct)
    %% time integral with RK4 method
    tendency_1 = get_tendency(dynamic_obj,cit,ct);

    temp_state_1 = dynamic_obj.add_increment(tendency_1,settings.integrator.step_size/2.0);
    tendency_2 = get_tendency(temp_state_1,cit,ct);

    temp_state_2 = dynamic_obj.add_increment(tendency_2,settings.integrator.step_size/2.0);
    tendency_3 = get_tendency(temp_state_2,cit,ct);

    temp_state_3 = dynamic_obj.add_increment(tendency_3,settings.integrator.step_size);
    tendency_4 = get_tendency(temp_state_3,cit,ct);

    dynamic_obj = dynamic_obj.add_increment_rk(tendency_1,tendency_2,tendency_3,tendency_4,settings.integrator.step_size);   
end

function tendency = get_tendency(dynamic_obj,cit,ct)
    tendency = dynamic_obj.tendency;
    if cit
        tendency = cellfun(@plus,tendency,ct,'UniformOutput',false);
    end
end  
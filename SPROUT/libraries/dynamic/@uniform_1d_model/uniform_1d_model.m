classdef uniform_1d_model
    properties
        varname
        vars
        time
        parm
        map
        periodical
        record
    end
    methods
        function obj=uniform_1d_model(varname,vars,parm,map,periodical,final_records)
            obj.periodical = periodical;
            obj.varname    = varname;
            obj.vars       = vars;
            obj.time       = 0;
            obj.parm       = parm;
            obj.map        = map;
            obj            = initialize_record(obj,final_records);
        end
        
        %% ----------------------------------------------------------
        % integral function
        % -----------------------------------------------------------
        
        function obj=add_increment(obj,tendency,step_size,add_time)
            for vnum=1:length(obj.varname)
                obj.vars{vnum} = obj.vars{vnum}+tendency.vars{vnum}*step_size;
            end
            if (~exist('add_time','var') || add_time ~= false)
                obj.time = obj.time+step_size;
            end
        end
        
        function obj=add_increment_rk(obj,tendency1,tendency2,tendency3,tendency4,step_size)
            for vnum=1:length(obj.varname)
                obj.vars{vnum} = obj.vars{vnum}+...
                                        tendency1.vars{vnum}*step_size/6+...
                                        tendency2.vars{vnum}*step_size/3+...
                                        tendency3.vars{vnum}*step_size/3+...
                                        tendency4.vars{vnum}*step_size/6;
            end
            obj.time = obj.time+step_size;
        end
        
        function obj=add_record(obj,note)
            obj.record.num = obj.record.num+1;
            
            for vnum=1:length(obj.varname)
                obj.record.vars{vnum}(obj.record.num,:) = obj.vars{vnum};
            end
            obj.record.time(obj.record.num) = obj.time;
            if exist('note','var')
                obj.record.note{obj.record.num} = note;
            end
        end
    end
end

function obj=initialize_record(obj,steps)
    for vnum=1:length(obj.varname)
        obj.record.vars{vnum} = zeros(steps,length(obj.vars{vnum}));
    end
    obj.record.note = cell(1,steps);
    obj.record.time = null(1,steps);
    obj.record.num = 0;
           
    obj = obj.add_record('initial');
end
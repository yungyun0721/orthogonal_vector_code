%% obj=shallow_water_cf(initial_field, settings)
% 
% create a 1d shallow water model object (Conservative Form)
% about formula plz read https://en.wikipedia.org/wiki/Shallow_water_equations
% with a assumption : H is constant
% 
% << vars >>
% index    :  1  ,  2
% variable :  h  ,  hu
% 
% << args >>
% initial_field : the initial condition
%                   *initial_field{1} = h;
%                   *initial_field{2} = (H+h)u;
% parm_args     : the paramemters on tendency equation
%                   *parm_args.H
%                   *parm_args.g
% map_args      : the map settings to be registered in one_dim_mapper
%                   *map_args.domain_size
%                   *map_args.domain_start
%                   *map_args.grid_points
% final_records : the estimated total steps which it will be ended
%                 it is used to pre-establish record space and save computing

%%
classdef shallow_water_cf < uniform_1d_model
    properties
    end
    methods
        function obj=shallow_water_cf(initial_field,settings)
            varname      = {'h';'hu'};
            vars         = initial_field;
            parm         = settings.parm_args;
            periodical   = settings.periodical;
            standard_map = one_dim_mapper(settings.map_args,periodical);
            map{1}       = standard_map;
            map{2}       = standard_map;
            if (~exist('final_records','var'))
                final_records = 1001;
            end
            obj@uniform_1d_model(varname,vars,parm,map,periodical,final_records);
        end
        
        %% ----------------------------------------------------------
        % tendency equation
        % -----------------------------------------------------------
        
        function [h, hu]=selector(obj,record_num)
            if (record_num == 0)
                h = obj.vars{1};
                hu = obj.vars{2};
            else
                h = obj.record.vars{1}(record_num,:);
                hu = obj.record.vars{2}(record_num,:);
            end
        end
        
        function output=tendency(obj,record_num)
            if (~exist('record_num','var'))
                record_num = 0;
            end
            [h, hu] = obj.selector(record_num);
            h = h+obj.parm.H;
            
            if obj.periodical
                output.vars{1} = -(shift.period(hu,+1)-shift.period(hu,-1))/(2*obj.map{2}.dx);
                temp = ((hu.^2.)./h)+(obj.parm.g*h.^2.)/2.;
                output.vars{2} = -(shift.period(temp,+1)-shift.period(temp,-1))/(2*obj.map{2}.dx);
            else
                output.vars{1} = -(shift.reflect(hu,+1)-shift.reflect(hu,-1))/(2*obj.map{2}.dx);
                temp = ((hu.^2.)./h)+(obj.parm.g*h.^2.)/2.;
                output.vars{2} = -(shift.mirror(temp,+1)-shift.mirror(temp,-1))/(2*obj.map{2}.dx);
            end
        end
    end
end
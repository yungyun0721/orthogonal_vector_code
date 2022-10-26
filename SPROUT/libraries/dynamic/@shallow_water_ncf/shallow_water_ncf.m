%% obj=shallow_water_ncf(initial_field, settings)
% 
% create a 1d shallow water model object (Non Conservative Form)
% about formula plz read https://en.wikipedia.org/wiki/Shallow_water_equations
% with an assumption : wave structure is uniform in y direction (d/dy = 0)
% 
% << vars >>
% index    : 1 , 2 , 3
% variable : h , u , v
% 
% << args >>
% initial_field : the initial condition
%                   *initial_field{1} = h;
%                   *initial_field{2} = u;
%                   *initial_field{3} = v;
% parm_args     : the paramemters on tendency equation
%                   *paem_args.H
%                   *parm_args.g
%                   *parm_args.f  (Coriolis coefficient)
%                   *parm_args.b  (viscous drag coefficient)
%                   *parm_args.mu (kinematic viscosity)
% map_args      : the map settings to be registered in one_dim_mapper
%                   *map_args.domain_size
%                   *map_args.domain_start
%                   *map_args.grid_points
% final_records : the estimated total steps which it will be ended
%                 it is used to pre-establish record space and save computing

%%
classdef shallow_water_ncf < uniform_1d_model
    properties
    end
    methods
        function obj=shallow_water_ncf(initial_field,settings)
            varname      = {'h';'u';'v'};
            vars         = initial_field;
            parm         = settings.parm_args;
            periodical   = settings.periodical;
            standard_map = one_dim_mapper(settings.map_args,periodical);
            map{1}       = standard_map;
            map{2}       = standard_map;
            map{3}       = standard_map;
            if (~exist('final_records','var'))
                final_records = 1001;
            end
            obj@uniform_1d_model(varname,vars,parm,map,periodical,final_records);
        end
        
        %% ----------------------------------------------------------
        % tendency equation
        % -----------------------------------------------------------
        
        function [h, u, v]=selector(obj,record_num)
            if (record_num == 0)
                h = obj.vars{1};
                u = obj.vars{2};
                v = obj.vars{3};
            else
                h = obj.record.vars{1}(record_num,:);
                u = obj.record.vars{2}(record_num,:);
                v = obj.record.vars{3}(record_num,:);
            end
        end
        
        function output=tendency(obj,record_num)
            if (~exist('record_num','var'))
                record_num = 0;
            end
            [h, u, v] = obj.selector(record_num);
            
            if obj.periodical
                output.vars{1} = -(shift.period((h+obj.parm.H).*u,+1)-shift.period((h+obj.parm.H).*u,-1))/(2*obj.map{1}.dx);
                output.vars{2} = -u.*(shift.period(u,+1)-shift.period(u,-1))/(2*obj.map{1}.dx)...
                                    +obj.parm.f.*v-obj.parm.g*(shift.period(h,+1)-shift.period(h,-1))/(2*obj.map{1}.dx)...
                                    -obj.parm.b*u+obj.parm.mu*(shift.period(u,+1)-shift.period(u,-1))/((obj.map{1}.dx)^2);
                output.vars{3} = -u.*(shift.period(v,+1)-shift.period(v,-1))/(2*obj.map{1}.dx)...
                                    -obj.parm.f.*u-obj.parm.b*v+obj.parm.mu*(shift.period(v,+1)-shift.period(v,-1))/((obj.map{1}.dx)^2);
            else
                output.vars{1} = -(shift.reflect((h+obj.parm.H).*u,+1)-shift.reflect((h+obj.parm.H).*u,-1))/(2*obj.map{1}.dx);
                output.vars{2} = -u.*(shift.reflect(u,+1)-shift.reflect(u,-1))/(2*obj.map{1}.dx)...
                                    +obj.parm.f.*v-obj.parm.g*(shift.mirror(h,+1)-shift.mirror(h,-1))/(2*obj.map{1}.dx)...
                                    -obj.parm.b*u+obj.parm.mu*(shift.reflect(u,+1)-shift.reflect(u,-1))/((obj.map{1}.dx)^2);
                output.vars{3} = -u.*(shift.reflect(v,+1)-shift.reflect(v,-1))/(2*obj.map{1}.dx)...
                                    -obj.parm.f.*u-obj.parm.b*v+obj.parm.mu*(shift.mirror(v,+1)-shift.mirror(v,-1))/((obj.map{1}.dx)^2);
            end
        end
    end
end
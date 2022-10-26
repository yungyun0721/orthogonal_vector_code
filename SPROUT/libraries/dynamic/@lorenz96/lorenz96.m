%% obj=lorenz96(initial_field, settings)
% 
% create a two-scale lorenz96 model object
% 
% << vars >>
% index    :  1  ,  2
% variable :  X  ,  Y
% 
% << args >>
% initial_field      : the initial condition
%                       *initial_field{1} = X
%                       *initial_field{2} = Y
% settings.parm_args : the paramemters on tendency equation
%                       *parm_args.c
%                       *parm_args.b
%                       *parm_args.h
%                       *parm_args.f
% settings.map_args  : the map settings to be registered in one_dim_mapper
%                       *map_args.x.domain_size = 360;
%                       *map_args.x.domain_start
%                       *map_args.x.grid_points
%                       *map_args.y.domain_size = 360;
%                       *map_args.y.domain_start
%                       *map_args.y.grid_points
% settings.final_records : the estimated total steps which it will be ended
%                       it is used to pre-establish record space and save computing

%%
classdef lorenz96 < uniform_1d_model
    properties
    end
    methods
        function obj=lorenz96(initial_field,settings)
            varname    = {'X';'Y'};
            vars       = initial_field;
            parm       = settings.parm_args;
            periodical = true;
            map{1}     = one_dim_mapper(settings.map_args.x,periodical);
            map{2}     = one_dim_mapper(settings.map_args.y,periodical);
            if (~isfield(settings,'final_records'))
                final_records = 7201;
            else
                final_records = settings.final_records;
            end
            obj@uniform_1d_model(varname,vars,parm,map,periodical,final_records);
        end
        
        %% ----------------------------------------------------------
        % tendency equation
        % -----------------------------------------------------------
        
        function [X, Y]=selector(obj,record_num)
            if (record_num == 0)
                X = obj.vars{1};
                Y = obj.vars{2};
            else
                X = obj.record.vars{1}(record_num,:);
                Y = obj.record.vars{2}(record_num,:);
            end
        end
        
        function output=tendency(obj,record_num)
            if (~exist('record_num','var'))
                record_num = 0;
            end
            [X, Y]=obj.selector(record_num);
            
            output.vars{1} = shift.period(X,-1).*(shift.period(X,+1)-shift.period(X,-2))-...
                            X+obj.parm.f+obj.G(record_num);
            output.vars{2} = obj.parm.c*obj.parm.b*shift.period(Y,+1).*(shift.period(Y,-1)-shift.period(Y,+2))-...
                            obj.parm.c*Y+obj.H(record_num);
        end

        function output=G(obj,record_num)
            if (~exist('record_num','var'))
                record_num = 0;
            end
            [X, Y]=obj.selector(record_num);
            
            factor   = -obj.parm.h*obj.parm.c/obj.parm.b;
            yx_ratio = fix(obj.map{2}.grid_points/obj.map{1}.grid_points);
            K = size(Y,1);
            
            output = zeros(size(X));
            output(:,:) = factor*squeeze(sum(reshape(Y,[K yx_ratio obj.map{1}.grid_points]),2));
        end
        
        function output=H(obj,record_num)
            if (~exist('record_num','var'))
                record_num = 0;
            end
            [X, ~]=obj.selector(record_num);
            
            factor   = obj.parm.h*obj.parm.c/obj.parm.b;
            yx_ratio = fix(obj.map{2}.grid_points/obj.map{1}.grid_points);
            K = size(X,1);
            output   = reshape(repmat(X,[yx_ratio 1]),[K obj.map{2}.grid_points])*factor;
        end
    end
end
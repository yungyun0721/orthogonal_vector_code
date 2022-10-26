classdef one_dim_mapper
    properties
        domain_size
        domain_start
        grid_points
        coordinate
        periodical
        dx
    end
    
    methods
        function obj = one_dim_mapper(map_args,periodical)
            if (length(map_args.domain_size)==1 && ...
                    length(map_args.domain_start)==1 && ...
                    length(map_args.grid_points)==1)
                obj.domain_size  = map_args.domain_size;
                obj.domain_start = map_args.domain_start;
                obj.grid_points  = map_args.grid_points;
                obj.periodical   = periodical;
                obj              = coordinating(obj);
            else
                error('one_dim_mapper : dim error')
            end
        end
    end
end

function obj = coordinating(obj)
    if (obj.periodical == 1)
        obj.coordinate = linspace(obj.domain_start,obj.domain_start+obj.domain_size,obj.grid_points+1);
        obj.coordinate = obj.coordinate(1:end-1);
    else
        obj.coordinate = linspace(obj.domain_start,obj.domain_start+obj.domain_size,obj.grid_points);
    end
    obj.dx = obj.coordinate(2)-obj.coordinate(1);
end
function coordinate=enlarged_periodical_coordinate(obj)
    coordinate = [obj.coordinate(1)-obj.dx, obj.coordinate, obj.coordinate(end)+obj.dx];
end
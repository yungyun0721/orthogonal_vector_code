function increment=get_increment(original,new)
    for vnum=1:length(original.vars)
        increment.vars{vnum} = new.vars{vnum}-original.vars{vnum};
    end
end
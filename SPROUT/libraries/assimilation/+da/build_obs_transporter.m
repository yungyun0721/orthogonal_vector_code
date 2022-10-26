%% H = build_obs_transporter(model,obs_collection,mss,oss);
%
% calculate the linear observation transport operator
%

%%
function H=build_obs_transporter(model,obs_collection,mss,oss)
    % check the integrity of observation corresponding background 
    check_integrity(mss,oss);

    % total model/observation space size
    M = sum(mss);
    O = sum(oss);

    % prepare coordinate info
    model_map = model.reference.map;
    obs_coordinate = obs_collection.record.coordinate;

    % initial transporter
    H = zeros(O,M);

    % prepare observation index
    [Ovnum, Ovindex] = prepare_observation_index(oss);

    % search and write transporter
    for obs_index=1:O
        coordinate = obs_coordinate{Ovnum(obs_index)}(Ovindex(obs_index));
        [Mindex, Hvalue] = interpolator(model_map{Ovnum(obs_index)}.coordinate,coordinate);
        xb_index = get_xb_index(Ovnum(obs_index),Mindex,mss);
        H(obs_index,xb_index) = Hvalue;
    end
end

%%
function [Ovnum, Ovindex]=prepare_observation_index(oss)
    rawOvnum = cell(1,length(oss));
    rawOvindex = cell(1,length(oss));

    for vnum=1:length(oss)
        if (oss(vnum)~=0)
            rawOvnum{vnum} = ones(1,oss(vnum))*vnum;
            rawOvindex{vnum} = 1:oss(vnum);
        end
    end

    Ovnum = cell2mat(rawOvnum);
    Ovindex = cell2mat(rawOvindex);
end

%% get the corresponding index in model and Hvalue 
function [Mindex, Hvalue]=interpolator(Mcoordinate,coordinate)
    mirror = 1:length(Mcoordinate);
    mirror_point = interp1(Mcoordinate,mirror,coordinate);
    if (mod(mirror_point,1)==0)
        Mindex = mirror_point;
        Hvalue = 1;
    else
        m1 = fix(mirror_point);
        m2 = m1+1;
        Hm1 = 1-mirror_point+m1;
        Hm2 = mirror_point-m1;
        Mindex = [m1 m2];
        Hvalue = [Hm1 Hm2];
    end
end

%% get the Hindex corresponding to oiginal oiginal
function xb_index=get_xb_index(vnum,Mindex,mss)
    xb_index = sum(mss(1:vnum-1))+Mindex;
end

%% check the integrity of observation corresponding background 
function check_integrity(mss,oss)
    if (length(mss) ~= length(oss))
        error('different variable length between model and observation')
    end
    
    vnum_list = 1:length(mss);
    model_available = setxor((mss~=0).*vnum_list,0);
    obs_available = setxor((oss~=0).*vnum_list,0);
    
    if (~isequal(intersect(model_available,obs_available),obs_available))
        model_available = setxor((mss~=0).*vnum_list,0)
        obs_available = setxor((oss~=0).*vnum_list,0)
        error('integrity check fail')
    end
end

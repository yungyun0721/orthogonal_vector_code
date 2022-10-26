%% sprout.initializer(threads)
% 
% Initialize for SPROUT Data Assimilation Experiment Framework
% it loads library and enables multi-thread function
% to ensure SPROUT work normally and efficiently.
% 
% << args >>
% threads : how many thread to create
%           this function require "Parallel Computing Toolbox"
%           set "0" if you do not want to enable multi-thread
% 
% << recommendation >>
% 1. the multi-thread efficiency is proportional to the steps of integration task.
%    because it will take time to exchange data between CPU cores.
%    if the integration task is too short, wasted time will more than saved time.
% 
%    *for example, to do 600 steps integration in 12 members
%                  seperate into 1 times 600 steps will take 52  sec 
%                  seperate into 10 times 60 steps will take 81  sec 
%                  seperate into 100 times 6 steps will take 362 sec
% 
% 2. the optimal thread number is decided by your CPU cores
%    for CPU has N cores, do not exceed N-1 threads
% 
% << self-intro >>
% author      : Lin Zhe-Hui
% update date : 2016/04/20
% note        : 

%% main
function initializer(threads)
    disp('sprout.initializer : initializing ...')
    load_library
    if (exist('threads','var') && threads ~= 0)
        enable_multithread(threads);
    end
    disp('sprout.initializer : done')
end

%% load library
function load_library()
    disp('sprout.initializer : loading library ...')
    myname = 'sprout.initializer';
    SPROUT_location = which(myname);
    SPROUT_location = SPROUT_location(1:end-length(myname)-4);
    libpath = {...
                '/libraries/assimilation';...
                '/libraries/observation';...
                '/libraries/common';...
                '/libraries/dynamic';...
                '/libraries/model';...
                '/libraries/integration';...
                '/libraries/map';...
               };
    for i=1:length(libpath)
        addpath([SPROUT_location,libpath{i}])
    end
end

%% enable multi-thread
function enable_multithread(threads)
    disp('sprout.initializer : enabling multi-thread ...')
    try
        if (parpool('size')<=0)
           parpool('open','local',threads);
        else
            disp('sprout.initializer : multi-thread is already initialized');
        end
    catch err
        throw(err)
    end
end
%% sprout.uninitializer()
% 
% End Simple Universal Model Driver.
% it disable multi-thread function to release memory
% and unload SPROUT library to prevent to be misused.
% 
% << self-intro >>
% author      : Lin Zhe-Hui
% update date : 2016/04/15
% note        : 

%%
function uninitializer()
    disp('sprout.uninitializer : ending ...')
    unload_library
    disable_multithread
    disp('sprout.uninitializer : done')
end

%% unload library
function unload_library()
    disp('sprout.uninitializer : unloading library ...')
    myname = 'sprout.uninitializer';
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
        rmpath([SPROUT_location,libpath{i}])
    end
end

%% disable multi-thread
function disable_multithread()
    if (matlabpool('size')>0)
        disp('sprout.uninitializer : disabling multi-thread ...')
        matlabpool close
    end
end
%% combine ensemble to be a matrix
function xb_matrix = metrix_ensemble(da_run,ii)

xb_matrix = zeros(length(da_run.ensmember{1}.vars{1}()),length(ii));

    for i=1:length(ii)
         xb_matrix(:,i) =  da_run.ensmember{ii(i)}.vars{1}();
    end
end



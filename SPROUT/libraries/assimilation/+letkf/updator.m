%% [xa_mean, xa_perturbation] = letkf.updator(xb_mean,xb_perturbation,mean_weighting,perturbation_weighting);
%
% part of Local Ensemble Transform Kalman Filter

%%
function [xa_mean, xa_perturbation] = updator(xb_mean,xb_perturbation,mean_weighting,perturbation_weighting,analyzed_xindex)
%%  initialize
    xa_mean = xb_mean;
    xa_perturbation = xb_perturbation;
    
%%  calculate for each grid point
    for xindex = analyzed_xindex
        % mean
        xa_mean(xindex) = xb_mean(xindex) + xb_perturbation(xindex,:)*mean_weighting{xindex};

        % perturbation
        xa_perturbation(xindex,:) = xb_perturbation(xindex,:)*perturbation_weighting{xindex};
    end
    

%     for xindex = analyzed_xindex
%     weighting=bsxfun(@plus,perturbation_weighting{xindex},mean_weighting{xindex});
%     xb=bsxfun(@plus,xb_perturbation(xindex,:),xb_mean(xindex));
%     xa(xindex,:)=xb*weighting;
%     xa_mean(xindex)=mean(xa(xindex),2)+xb_mean(xindex);
%     xa_perturbation(xindex,:)=bsxfun(@minus,xa(xindex,:),xa_mean(xindex));
%     end
end
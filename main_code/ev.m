%% EV1 for Lorenz96
function [EV1,S,all_EV]=ev(xb,n)



xb_pert = bsxfun(@minus,xb,mean(xb,2));
xb_energy_norm=xb_pert'*xb_pert;

%   eigenvalue(or SVD)
% digits(128)
[U,S]=eig(xb_energy_norm);
%     U=double(U);
%     S=double(S);

    
    for i=1:length(xb(1,:))-1
        S_tmp=S(i,i);
        U_tmp=U(:,i);
        for j=i+1:length(xb(1,:))
            if abs(S_tmp)<abs(S(j,j))
               S(i,i)=S(j,j);
               U(:,i)=U(:,j);
               S(j,j)=S_tmp;
               U(:,j)=U_tmp;
            end
           S_tmp=S(i,i);
           U_tmp=U(:,i);
        end
    end
%     
% %   SVD
%     digits(512)
%     [U,S,V]=svd(vpa(xb_energy_norm),0);
%     U=double(U);
%     S=double(S);
%     V=double(V);
    
    
    
    all_EV=xb*U;

 %ev
   EV1=zeros(length(xb(:,1)),1);
    for i = 1:length(xb(:,1))
        j = n;
            for k = 1 : length(xb(1,:))
                EV1(i,1) = EV1(i,1)+xb_pert(i,k).*U(k,j);
            end
        
    end
end

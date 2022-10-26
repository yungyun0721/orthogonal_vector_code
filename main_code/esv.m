%% ensemble singular vector for lorenz96 model
function [IESV, FESV,S,all_FESV,all_IESV,energy_initial,energy_final]=esv(xb_initial,xb_final,esv_number)
%% initialize
    ens_mem=length(xb_initial(1,:));
    ci=eye(length(xb_initial(:,1))); %initial norm
    cf=eye(length(xb_final(:,1))); %final norm
    
    %initial ensemble perturbation 
    xb_initial_mean =mean(xb_initial,2);
    xb_initial_perturbation = bsxfun(@minus,xb_initial,xb_initial_mean);
    
    %final ensemble perturbation 
    xb_final_mean =mean(xb_final,2);
    xb_final_perturbation = bsxfun(@minus,xb_final,xb_final_mean);
    
%   %energy norm
    energy_initial=xb_initial_perturbation'*ci*xb_initial_perturbation;
    energy_final  =xb_final_perturbation'*cf*xb_final_perturbation;
   
%   %eigenvalue(or SVD)
       WR=zeros(ens_mem,ens_mem);WI=zeros(ens_mem,ens_mem);VL=zeros(ens_mem,ens_mem); VR=zeros(ens_mem,ens_mem);
     LDVL=ens_mem;LDVR=ens_mem;wk=3*ens_mem-1;info=0;
     
     %b=vpa(inv(vpa(energy_initial))*energy_final);
   %b=pinv(energy_initial)*energy_final;
   C = lapack('DGEEV', 'V', 'V', ens_mem, energy_initial, ens_mem, WR, WI,VL, LDVL, VR, LDVR,wk,-1,info);
   [energy_initial_u,energy_initial_s]=eig(energy_initial);
   C = lapack('DGEEV', 'V', 'V', ens_mem, energy_final, ens_mem, WR, WI,VL, LDVL, VR, LDVR,wk,-1,info);
   [energy_final_u,energy_final_s]=eig(energy_final);
       for i=1:length(xb_initial(1,:))-1
        energy_initial_S_tmp=energy_initial_s(i,i);
        energy_initial_U_tmp=energy_initial_u(:,i);
        energy_final_S_tmp=energy_final_s(i,i);
        energy_final_U_tmp=energy_final_u(:,i);
        for j=i+1:length(xb_initial(1,:))
                 if abs(energy_initial_S_tmp)<abs(energy_initial_s(j,j))
                     energy_initial_s(i,i)=energy_initial_s(j,j);
                     energy_initial_u(:,i)=energy_initial_u(:,j);
                     energy_initial_s(j,j)=energy_initial_S_tmp;
                     energy_initial_u(:,j)=energy_initial_U_tmp;
                 end
            energy_initial_S_tmp=energy_initial_s(i,i);
            energy_initial_U_tmp=energy_initial_u(:,i);
        end
            for j=i+1:length(xb_initial(1,:))
                if abs(energy_final_S_tmp)<abs(energy_final_s(j,j))
                     energy_final_s(i,i)=energy_final_s(j,j);
                     energy_final_u(:,i)=energy_final_u(:,j);
                     energy_final_s(j,j)=energy_final_S_tmp;
                     energy_final_u(:,j)=energy_final_U_tmp;
                end
            energy_final_S_tmp=energy_final_s(i,i);
            energy_final_U_tmp=energy_final_u(:,i);
            end
       end    
   inv_energy_initial_s=zeros(i,i);
       for j=1:length(xb_initial(1,:))-1
       inv_energy_initial_s(j,j)=1./energy_initial_s(j,j);
       end
   inv_energy_initial=energy_initial_u(:,1:i)* inv_energy_initial_s*energy_initial_u(:,1:i)';
   new_energy_final=energy_final_u(:,1:i)* energy_final_s(1:i,1:i)*energy_final_u(:,1:i)';
   b=inv_energy_initial*new_energy_final;
    %b=double(b);
%     [initial_U,initial_S]=eig(energy_initial);
%     initial_Vr=zeros(length(initial_S)-1,length(initial_S)-1);
%     for i=1:length(initial_S)-1
%         initial_Vr(i,i)=1./initial_S(i+1,i+1);
%     end
%     inv_energy_initial=initial_U(:,2:length(initial_S))*initial_Vr*initial_U(:,2:length(initial_S))';
%     
%     [final_U,final_S]=eig(energy_final);
%     final_Vr=zeros(length(final_S)-1,length(final_S)-1);
%     for i=1:length(final_S)-1
%         final_Vr(i,i)=1./final_S(i+1,i+1);
%     end
%     new_energy_final=final_U(:,2:length(final_S))*final_Vr*final_U(:,2:length(final_S))';
    %b=vpa(inv(vpa(energy_initial))*energy_final);
%      digits(1024)
%     b=pinv(energy_initial)* energy_final;
%     [U,S]=eig(vpa(b));
%      U=double(U);
%      S=double(S);
%      

     C = lapack('DGEEV', 'V', 'V', ens_mem, b, ens_mem, WR, WI,VL, LDVL, VR, LDVR,wk,-1,info);
     [U,S]=eig(b);

    for i=1:length(xb_initial(1,:))-1
        S_tmp=S(i,i);
        U_tmp=U(:,i);
        for j=i+1:length(xb_initial(1,:))
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
    V=U;

 
%     b=vpa(inv(vpa(energy_initial))*energy_final);
%     [U,S,V]=svd(vpa(b),0);
%     U=double(U);
%     S=double(S);
%     V=double(V);
     
    %initial ESV & final ESV
    all_IESV=xb_initial_perturbation*V;
    all_FESV=xb_final_perturbation*U;
    
    IESV=zeros(length(xb_initial(:,1)),1);
    FESV=zeros(length(xb_initial(:,1)),1);
    
    for i = 1:length(xb_initial(:,1))
        for j = esv_number
            for k = 1 : length(xb_initial(1,:))
            IESV(i,1) = IESV(i,1)+xb_initial_perturbation (i,k).*V(k,j);
            FESV(i,1) = FESV(i,1)+xb_final_perturbation (i,k).*U(k,j);
            end
        end
    end
    
    

    
    
end
    
    
   
    
    
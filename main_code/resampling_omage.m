function omage=resampling_omage(m)
%m*m-1 ensemble size
omage=(-1)*((1/((1/sqrt(m))+1))/m).*ones(m,m-1);
for i=1:m-1
    omage(i,i)=1-((1/((1/sqrt(m))+1))/m);
end
omage(m,:)=(-1)*1/sqrt(m);
%omage'*omage % (m-1)*(m-1)
end
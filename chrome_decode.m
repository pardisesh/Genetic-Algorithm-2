function[real_val]=chrome_decode(Population,N,L,BS,m,Lo,Hi)
real_val=[];
STED(1)=1;
for i=2:m+1
    STED(i)=STED(i-1)+BS(i-1);
end

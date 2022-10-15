clc;
clear all;
N=50;
Pc=0.9;
Pm=0.005;
ITER=100;
m=10;
BS=[10 10];
L=sum(BS);
Lo=[-4 -1.5];
Hi=[2 1];
Population=round(rand(N,L));
best_so_far=[];
Average_fitness=[];
for it=1:ITER
[real_val]=chrom_decode(Population,N,L,BS,m,Lo,Hi);
[selection_probability,fit,ave_fit,max_fit,opt_sol]=fit_eval(real_val,N,m);
if it==1
    best_so_far(it)=max_fit;
    final_sol=opt_sol;
elseif max_fit>best_so_far(it-1)
    best_so_far(it)=max_fit;
    final_sol=opt_sol;
else
    best_so_far(it)=best_so_far(it-1);
end
Average_fitness(it)=ave_fit;
%%%%
[mating_pool]=g_roulette_wheel(Population,N,selection_probability);
[new_pop]=g_crossover(mating_pool,Pc,N,L);
[population]=g_mutation(new_pop,Pm,N,L);
end
display('final solution  optimum fitness');
result=[final_sol,best_so_far(end)]
x=1:ITER;
figure.plot(x,best_so_far,'k',x,Average_fitness,'.-k');
xlabel('Generation');
ylabel('Fitness Function')
legend('Best-so-far','Average fitness')
for j=1:m
   x=BS(j)-1:-1:0;
   Pow2x=2.^x;
   for i=1:N
       gene=Population(i,STED(j):STED(j+1)-1);
       Var_norm=sum(Pow2x.*gene)/(2^BS(j)-1);
       real_val(i,j)=Lo(j)+(Hi(j)-Lo(j))*Var_norm;
   end
end
for i=1:N
    r=rand;
    for j=1:N
        if r<=cdf(j)
            mating_pool(i,:)=Population(j,:);
            break;
        end
    end
end
return;
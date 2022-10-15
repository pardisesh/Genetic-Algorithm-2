function[mating_pool]=g_roulette_wheel(Population,N,selection_probability)
cdf(1)=selection_probability(1);
for i=2:N
    cdf(i)=cdf(i-1)+selection_probability(i);
end

function [spins_list,labels] = sw(Wp,beta_list,n_sweep)

n = size(Wp,1); m = size(Wp,2);
spins_list = rand_spins_2d(n,m);

beta_min = beta_list(1); beta_max = beta_list(2);
for sweep = 1:n_sweep
    
    beta = beta_min + (sweep-1)/(n_sweep-1)*(beta_max - beta_min);
    [labels,index_list] = connect(spins_list,Wp,beta);
    for index = index_list
        if floor(1/2 + rand())
            spins_list(labels == index) = -spins_list(labels == index);
        end
    end
    
end

end
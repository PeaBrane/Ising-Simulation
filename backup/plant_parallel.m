clear all;
rng(0);

n_runs1 = 100; 
% n_runs2 = 1;
N_RUNS1 = 100;
N_RUNS2 = 100;

n_list = [55:5:60];
n = 10; 
m = 10; 
scale = 1; 

density_list = 0.47; %0.47
loop_ratio = 1; 
frus_list = [0.2]; 
vers = 0; 

n_monte_list_tot = [10000 10000 100000;
                    10000 10000 100000];
beta = [0.01 log(n)];

density = density_list;
frus = frus_list;

n_length = length(n_list);
monte_length_tot = zeros(1,n_length);
for n_iter = 1:n_length
    list = n_monte_list_tot(n_iter,:);
    monte_length_tot(n_iter) = round((list(3) - list(1))/list(2)) + 1;
end

tot_length = n_length*n_runs1;
time_list = zeros(sum(monte_length_tot),n_runs1);

for tot_iter = 1:tot_length

dummy = zeros(sum(monte_length_tot),n_runs1);   

n_iter = floor((tot_iter-1)/n_runs1)+1;
run1 = mod(tot_iter-1,n_runs1)+1;
    
n = n_list(n_iter);
m = n_list(n_iter);

n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

n_monte_list = [n_monte_list_tot(n_iter,1):n_monte_list_tot(n_iter,2):n_monte_list_tot(n_iter,3)];
monte_length = monte_length_tot(n_iter);
for monte_iter = 1:monte_length
n_monte = n_monte_list(monte_iter);
index = sum(monte_length_tot(1:n_iter)) - monte_length_tot(n_iter) + monte_iter;
dummy(index,run1) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,10000000,0.02,n_loops);
end
time_list = time_list + dummy;

% time_list(tot_iter) = get_time_Falcon(n,m,a,b,w,E,10000,0.02);

end

for n_iter = 1:n_length
n_monte_list = [n_monte_list_tot(n_iter,1):n_monte_list_tot(n_iter,2):n_monte_list_tot(n_iter,3)];
monte_length = monte_length_tot(n_iter);
n = n_list(n_iter);

for monte_iter = 1:monte_length
n_monte = n_monte_list(monte_iter);
index = sum(monte_length_tot(1:n_iter)) - monte_length_tot(n_iter) + monte_iter;

list = time_list(index,:);
parsave(strcat('Gibbs-',num2str(n),'-',num2str(n_monte),'.mat'),list);
 
end
end

% for monte_iter = 1:monte_length
% list = time_matrix(:,monte_iter).';
% parsave(strcat('size',num2str(n),'.mat'),list);
% list = log(list);
% list_mean = mean(list);
% list_std = std(list);
% time_95 = exp(list_mean + 2*list_std);
% time_list(n_iter,monte_iter) = time_95;
% end

% scatter(n_list,time_list);
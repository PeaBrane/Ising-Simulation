clear all;
rng(0);

n_runs1 = 10; 

n_list = [10:5:30];
scale = 1; 

density = 0.47;
frus = 0.2;
loop_ratio = 1; 
vers = 0; 

n_monte_list_tot = [15 1 30;
                    70 1 100;
                    150 1 200;
                    275 1 325
                    450 1 500];

n_length = length(n_list);
monte_length_tot = zeros(1,n_length);
for n_iter = 1:n_length
    list = n_monte_list_tot(n_iter,:);
    monte_length_tot(n_iter) = round((list(3) - list(1))/list(2)) + 1;
end

tot_length = n_length*n_runs1;
time_list = zeros(sum(monte_length_tot),n_runs1);

parfor tot_iter = 1:tot_length

dummy = zeros(sum(monte_length_tot),n_runs1);   

n_iter = floor((tot_iter-1)/n_runs1)+1;
run1 = mod(tot_iter-1,n_runs1)+1;
    
n = n_list(n_iter);
m = n_list(n_iter);
beta = [0.01 log(n)];

n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

n_monte_list = [n_monte_list_tot(n_iter,1):n_monte_list_tot(n_iter,2):n_monte_list_tot(n_iter,3)];
monte_length = monte_length_tot(n_iter);
for monte_iter = 1:monte_length
n_monte = n_monte_list(monte_iter);
index = sum(monte_length_tot(1:n_iter)) - monte_length_tot(n_iter) + monte_iter;
dummy(index,run1) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,1000000,0,n_loops);
end
time_list = time_list + dummy;

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
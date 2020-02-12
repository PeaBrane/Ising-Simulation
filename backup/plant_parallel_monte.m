clear all;
rng(0);

n_list = [100:10:200];
scale = 1; 
n_length = length(n_list);

runs_list = ceil(10000*0.977.^(n_list-100));
runs_sum = runs_list;
for n_iter = 1:n_length
    runs_sum(n_iter) = sum(runs_list(1:n_iter));
end

density = 0.47;
frus = 0.2;
loop_ratio = 1; 
vers = 0; 
dev = 0;

monte_list = exp(-2.77)*n_list.^2.62;

tot_length = sum(runs_list);
time_list = zeros(1,tot_length);

parfor tot_iter = 1:tot_length 

rs = [runs_sum tot_iter];
rs = sort(rs,'ascend');
n_iter = min(find(rs == tot_iter));
if n_iter == 1
    run = tot_iter;
else
    run = tot_iter - runs_sum(n_iter-1);
end
    
n = n_list(n_iter);
m = n_list(n_iter);
beta = [0.01 log(n)];

n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

n_monte = monte_list(n_iter);
time_list(tot_iter) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,10000000,dev,n_loops)

end

for n_iter = 1:n_length

n = n_list(n_iter);
monte = monte_list(n_iter);
if n_iter == 1
    list = time_list(1:runs_sum(n_iter));
else
    list = time_list(runs_sum(n_iter-1)+1:runs_sum(n_iter));
end

parsave(strcat('Gibbs-',num2str(n),'-',num2str(monte),'.mat'),list);

end
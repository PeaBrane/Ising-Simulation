clear all;
rng(0);

n_list = [10:5:35];
scale = 1; 
n_length = length(n_list);

runs_list(1:n_length) = 100;
runs_sum = runs_list;
for n_iter = 1:n_length
    runs_sum(n_iter) = sum(runs_list(1:n_iter));
end

frus = 0.24;
loop_ratio = 1; 
vers = 0; 
dev = 0;

tot_length = sum(runs_list);
time_list = zeros(1,tot_length);

for tot_iter = 1:tot_length 

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

density = 0.3035 + 0.2952*exp(-0.0196*n);
n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

time_list(tot_iter) = get_time_Falcon(n,m,a,b,w,E,1000000,dev,[3 9]);

end

for n_iter = 1:n_length

n = n_list(n_iter);
if n_iter == 1
    list = time_list(1:runs_sum(n_iter));
else
    list = time_list(runs_sum(n_iter-1)+1:runs_sum(n_iter));
end

parsave(strcat('Falcon-',num2str(n),'.mat'),list);

end
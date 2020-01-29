clear all;
rng(0);

delete(gcp('nocreate'));
rudy = parpool('local',48);

scale = 100; 
frus = 0.25;
loop_ratio = Inf; 
vers = 1; 
dev = 0;

runs = 200; 

n_list = [30];
n_length = length(n_list);

density_list = 0.1*1.12.^[2:2:50];
density_length = length(density_list);

sz_list = [0.5:0.1:0.8];
sz_length = length(sz_list);

tot_length = n_length*sz_length*density_length;
time_list = zeros(1,tot_length);

%%%%% Run %%%%%

parfor tot_iter = 1:tot_length 

[n_iter,sz_iter,density_iter] = ind2sub([n_length sz_length density_length], tot_iter);  
n = n_list(n_iter); sz = sz_list(sz_iter); density = density_list(density_iter);
m = n;
n_loops = ceil(density*n);
beta = [0.01 log(n)]/scale;
n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);

list = zeros(1,runs);
for run = 1:runs
[w,~,~,E] = gen_abW(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
a = zeros(1,n); b = zeros(1,m);
list(run) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,1000000000,dev);
end

parsave(strcat(num2str(n),'-',num2str(sz),'-',num2str(density),'.mat'),list);

end

delete(rudy);
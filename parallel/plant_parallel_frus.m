clear all;
rng(0);

n_runs1 = 10000;

n_list = [20:10:60];
scale = 1; 
n_length = length(n_list);

density = 0.47;
frus_list = [0.05:0.025:0.2];
frus_length = length(frus_list);

loop_ratio = 1; 
vers = 0; 
dev = 0;

monte_tot = [5:1:25; 5:1:25; 5:1:25; 5:1:25; 10:1:30; 30:2:70; 200:10:400;
             5:2:45; 5:2:45; 5:2:45; 5:2:45; 20:2:60; 50:2:90; 200:15:500;
             5:2:45; 5:2:45; 5:2:45; 15:2:55; 20:2:60; 50:4:130; 400:20:800;
             5:2:45; 5:2:45; 5:2:45; 20:2:60; 40:2:80; 100:10:300; 750:25:1250;
             5:2:45; 40:2:80; 50:2:90; 50:2:90; 70:2:110; 100:20:500; 800:50:1800];
monte_length = length(monte_tot(1,:));

tot_length = n_length*frus_length*n_runs1;
time_list = zeros(n_length*frus_length*monte_length,n_runs1);

for tot_iter = 1:tot_length

dummy = zeros(n_length*frus_length*monte_length,n_runs1); 

run1 = mod(tot_iter-1,n_runs1) + 1;
quo = fix((tot_iter-1)/n_runs1) + 1;
frus_iter = mod(quo-1,frus_length) + 1;
n_iter = fix((quo-1)/frus_length) + 1;
    
n = n_list(n_iter);
m = n_list(n_iter);
beta = [0.01 log(n)];
frus = frus_list(frus_iter);

n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

tic;
monte_list = monte_tot(quo,:);
for monte_iter = 1:monte_length
n_monte = monte_list(monte_iter);
index = (n_iter-1)*frus_length*monte_length + (frus_iter-1)*monte_length + monte_iter;
dummy(index,run1) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,1000000,dev,n_loops);
end
toc;

time_list = time_list + dummy;

end

for n_iter = 1:n_length
n = n_list(n_iter);
for frus_iter = 1:frus_length
frus = frus_list(frus_iter);
quo = (n_iter-1)*frus_length + frus_iter;
monte_list = monte_tot(quo,:);
for monte_iter = 1:monte_length
n_monte = monte_list(monte_iter);

index = (n_iter-1)*frus_length*monte_length + (frus_iter-1)*monte_length + monte_iter;
list = time_list(index,:);
parsave(strcat('Gibbs-',num2str(n),'-',num2str(frus),'-',num2str(n_monte),'.mat'),list);
 
end
end
end
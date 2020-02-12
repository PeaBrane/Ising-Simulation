clear all;
rng(0);

scale = 1; 
frus = 0.2;
loop_ratio = 1; 
vers = 0; 
dev = 0;

runs = 1000; 

n_list = [80:10:100];

density_list = [0.3:0.01:0.5];
density_length = length(density_list);

n_length = length(n_list);
tot_length = n_length*density_length*runs;

time_list = zeros(1,tot_length);

for tot_iter = 1:tot_length 

run = mod(tot_iter-1,runs)+ 1;
quo = fix((tot_iter-1)/runs) + 1;
density_iter = mod(quo-1,density_length)+ 1;
n_iter = fix((quo-1)/density_length) + 1;
    
n = n_list(n_iter);
m = n_list(n_iter);
beta = [0.01 log(n)];

density = density_list(density_iter);
n_loops = ceil(density*(n+1));

tic;
[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);
toc;

n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);

tic;
time_list(tot_iter) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,1000000000,dev,n_loops);
toc;

end

for n_iter = 1:n_length
    for density_iter = 1:density_length
        n = n_list(n_iter); density = density_list(density_iter);
        quo = (n_iter-1)*density_length + density_iter;
        index = (quo-1)*runs+1:quo*runs;
        list = time_list(index);
        parsave(strcat('Gibbs-',num2str(n),'-',num2str(density),'.mat'),list);
    end
end
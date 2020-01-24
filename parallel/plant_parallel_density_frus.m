clear all;
rng(0);

scale = 1; 
loop_ratio = 1; 
vers = 0; 
dev = 0;

runs = 10000; 

n_list = [30:10:200];

density_list = 0.1*1.12.^[1:20];
density_length = length(density_list);

frus_list = [0.05];
frus_length = length(frus_list);

n_length = length(n_list);
tot_length = n_length*density_length*frus_length*runs;

time_list = zeros(1,tot_length);

parfor tot_iter = 1:tot_length 

run = mod(tot_iter-1,runs)+ 1;
quo = fix((tot_iter-1)/runs) + 1;
frus_iter = mod(quo-1,frus_length)+ 1;
quo = fix((quo-1)/frus_length) + 1;
density_iter = mod(quo-1,density_length)+ 1;
n_iter = fix((quo-1)/density_length) + 1;
    
n = n_list(n_iter);
m = n_list(n_iter);
beta = [0.01 log(n)];

density = density_list(density_iter);
n_loops = ceil(density*(n+1));

frus = frus_list(frus_iter);

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);

time_list(tot_iter) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,1000000000,dev,n_loops);

end

for n_iter = 1:n_length
    n = n_list(n_iter);
    for density_iter = 1:density_length
        density = density_list(density_iter);
        for frus_iter = 1:frus_length
        frus = frus_list(frus_iter);
            quo = (n_iter-1)*density_length*frus_length + (density_iter-1)*frus_length + frus_iter;
            index = (quo-1)*runs+1:quo*runs;
            list = time_list(index);
            parsave(strcat('Gibbs-',num2str(frus),'-',num2str(n),'-',num2str(density),'.mat'),list);
        end
    end
end
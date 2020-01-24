clear all;
rng(0);

n_runs1 = 100; 

n_list = [30:5:50];
scale = 1; 

density = 0.47;
frus = 0.2;
loop_ratio = 1; 
vers = 0; 

tpar_list_tot = [0.1 0.5 2.1;
                 0.1 0.5 2.1;
                 0.1 0.5 2.1;
                 0.5 1 4.5;
                 0.5 1 4.5];

n_length = length(n_list);
tpar_length_tot = zeros(1,n_length);
for n_iter = 1:n_length
    list = tpar_list_tot(n_iter,:);
    tpar_length_tot(n_iter) = round((list(3) - list(1))/list(2)) + 1;
end

tot_length = n_length*n_runs1;
time_list = zeros(sum(tpar_length_tot),n_runs1);

parfor tot_iter = 1:tot_length

dummy = zeros(sum(tpar_length_tot),n_runs1);   

n_iter = floor((tot_iter-1)/n_runs1)+1;
run1 = mod(tot_iter-1,n_runs1)+1;
    
n = n_list(n_iter);
m = n_list(n_iter);
beta = [0.01 log(n)];

n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

tpar_list = [tpar_list_tot(n_iter,1):tpar_list_tot(n_iter,2):tpar_list_tot(n_iter,3)];
tpar_length = tpar_length_tot(n_iter);
for tpar_iter = 1:tpar_length
tpar = tpar_list(tpar_iter);
index = sum(tpar_length_tot(1:n_iter)) - tpar_length_tot(n_iter) + tpar_iter;
dummy(index,run1) = get_time_Falcon(n,m,a,b,w,E,1000000,0,[tpar 3*tpar]);
end
time_list = time_list + dummy;

end

for n_iter = 1:n_length
tpar_list = [tpar_list_tot(n_iter,1):tpar_list_tot(n_iter,2):tpar_list_tot(n_iter,3)];
tpar_length = tpar_length_tot(n_iter);
n = n_list(n_iter);

for tpar_iter = 1:tpar_length
tpar = tpar_list(tpar_iter);
index = sum(tpar_length_tot(1:n_iter)) - tpar_length_tot(n_iter) + tpar_iter;

list = time_list(index,:);
parsave(strcat('Falcon-',num2str(n),'-',num2str(tpar),'.mat'),list);
 
end
end
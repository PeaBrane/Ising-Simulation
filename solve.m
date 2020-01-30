function time_list = solve(n_list,vers_list,sz_list,frus_list,density_list,scale,loop_ratio,runs,dev,cap)

n_length = length(n_list);
vers_length = length(vers_list);
sz_length = length(sz_list);
frus_length = length(frus_list);
density_length = length(density_list);

siz = [runs density_length frus_length sz_length vers_length n_length];
tot = prod(siz);
time_list = zeros(1,tot);

for tot_iter = 1:tot

[~,density_iter,frus_iter,sz_iter,vers_iter,n_iter] ...
= ind2sub([runs,density_length,frus_length,sz_length,vers_length,n_length], tot_iter);

n = n_list(n_iter); m = n_list(n_iter);
vers = vers_list(vers_iter);
sz = sz_list(sz_iter);
frus = frus_list(frus_iter);
density = density_list(density_iter);

n_loops = ceil(density*n);
beta = [0.01 log(n)]/scale;

[w,E] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz);

n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);

a = zeros(1,n); b = zeros(1,m);
time = SA_time(n,m,a,b,w,n_monte,beta,E,10^cap,dev);
time_list(tot_iter) = time;

if mod(tot_iter,ceil(tot/100)) == 0
    fprintf('.');
end

end

siz(siz == 1) = [];
time_list = reshape(time_list,siz); 

end
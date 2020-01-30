function solve_parallel(folder,n_list,vers_list,sz_list,frus_list,density_list,scale,loop_ratio,runs,dev,cap)

mkdir(folder);

siz = [length(density_list) length(frus_list) length(sz_list) length(vers_list) length(n_list)];
list = {density_list frus_list sz_list vers_list n_list};
tot = prod(siz);

[~,ll] = collapse(list);

parfor iter = 1:tot

vars = get_vars(list,iter);

density = vars(1); frus = vars(2); sz = vars(3); vers = vars(4);
n = vars(5); m = vars(5);

n_loops = ceil(density*n);
beta = [0.01 log(n)]/scale;
a = zeros(1,n); b = zeros(1,m);

timelist = zeros(1,runs);
for run = 1:runs
[w,E] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);
timelist(run) = SA_time(n,m,a,b,w,n_monte,beta,E,10^cap,dev);
end

fn = get_fn(ll,iter);
fn = strcat(folder,'/',fn);
parsave(fn,timelist);

end

end
function solve_parallel(folder,workers,runs,dev,cap,scale,loop_ratio,varlist,beta_smart)

% if exist(folder, 'dir')
%     rmdir(folder, 's');
% end
% mkdir(folder);

ins = round(runs/workers);

siz = cellfun(@length, varlist);
tot = prod(siz);

[~,vl] = collapse(varlist);

parfor ii = 1:tot*workers

iter = fix((ii-1)/workers)+1;
work = mod(ii-1,workers)+1;

vars = get_vars(varlist,iter);

density = vars(1); frus = vars(2); sz = vars(3); vers = vars(4);
n = vars(5); m = vars(5);

n_loops = ceil(density*n);
beta = betalist(n, density, scale, beta_smart);
a = zeros(1,n); b = zeros(1,m);

fn = get_fn(vl,iter,work);
fn = strcat(folder,fn);

if ~isfile(fn)
tlist = zeros(1,ins);
for in = 1:ins
[w,E] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);
tlist(in) = SA_time(n,m,a,b,w,n_monte,beta,E,10^cap,dev);
end
parsave(fn,tlist);
end

end

end
function timelist = solve(scale,loop_ratio,runs,dev,cap,perc,varlist,beta_smart)
% generate and solve instances parameterized by elements in varlist
% runs is the number of instances per class
% perc is the desired percentile

siz = cellfun(@length, varlist);
tot = prod(siz);

timelist = zeros(runs,tot);

for iter = 1:tot

vars = get_vars(varlist,iter);

density = vars(1); frus = vars(2); sz = vars(3); vers = vars(4);
n = vars(5); m = vars(5);

% number of loops
n_loops = ceil(density*n);
% setting the appropriate inverse temperature schedule
beta = betalist(n, density, scale, beta_smart);
% setting the appropriate sweeping schedule
n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);

% get the TTS distribution for class vars up to perc
wlist = zeros(n,m,runs); Elist = zeros(1,n);
for run = 1:runs
[w,E] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
wlist(:,:,run) = w; Elist(run) = E;
end      
list = get_timelist(runs,wlist,Elist,n_monte,beta,cap,perc,dev);
timelist(:,iter) = list.';

fprintf('.');

end

end
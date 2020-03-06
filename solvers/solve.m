function timelist = solve(runs,dev,T,scale,cloops,varlist,beta_smart)

siz = cellfun(@length, varlist);
tot = prod(siz);
timelist = zeros(1,tot*runs);

for iter = 1:tot

vars = get_vars(varlist,iter);

rho = vars(1); frus = vars(2); sz = vars(3); vers = vars(4);
n = vars(5); m = vars(5);

beta = betalist(n, rho, scale, beta_smart);

for run = 1:runs
[w,Esol,~] = rbmloops(n,m,scale,rho,cloops,vers,frus,sz);
t = opttime(n,frus);
timelist((iter-1)*runs+run) = SA_time(beta,Esol,w,T,t,dev);
end

mydot(iter,tot,1,1);
end

end
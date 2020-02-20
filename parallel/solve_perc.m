function solve_perc(folder,runs,workers,perc,varlist,scale,cloops,bsmart,T)

% if exist(folder, 'dir')
%     rmdir(folder, 's');
% end
mkdir(folder);

ins = round(runs/workers);

siz = cellfun(@length, varlist);
tot = prod(siz);
[~,vl] = collapse(varlist);

parfor ii = 1:tot*workers

iter = fix((ii-1)/workers)+1;
work = mod(ii-1,workers)+1;

vars = get_vars(varlist,iter);

rho = vars(1); frus = vars(2); sz = vars(3); vers = vars(4);
n = vars(5); m = vars(5);

betapara = betalist(n, rho, scale, bsmart);
t = opttime(n, frus);

fn = get_fn(vl,iter,work);
fn = strcat(folder,fn);

if ~isfile(fn)
[Wlist,Elist] = rbm_ensemble(n,m,scale,rho,cloops,vers,frus,sz,ins);
[tlist,~] = SArbm_perc(betapara,Wlist,Elist,T,t,perc+10);
end
parsave(fn,tlist);
end

end
function tlist = SA_perc(betapara,t0,fSDP,Esol,Wlist,T,perc)

sz = size(Wlist); runs = sz(end);
sz = sz(1:end-2); d = length(sz);

tlist = zeros(1,runs);

solved = zeros(1,runs);
runcap = min(ceil(runs*perc/100)+1, runs);

for restart = 1:100
Elist = zeros(1,runs);
list = zeros(1,runs);
parfor run = 1:runs

if d == 2
W = Wlist(:,:,:,run);
elseif d == 3
W = Wlist(:,:,:,:,run);
end

if ~solved(run)
[Elist(run),list(run)] ...
= SA_lattice(betapara,t0,fSDP,Esol,W,T,1);
end

end

tlist = tlist + list;
solved = solved + (Elist == Esol);
counter = sum(solved);
if counter >= runcap
    break;
end
end
tlist(~solved) = Inf;

end
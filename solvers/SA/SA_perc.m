function tlist = SA_perc(betapara,Esol,Wlist,T,perc)

sz = size(Wlist); d = length(sz)-2; runs = sz(end);

tlist = zeros(1,runs);
counter = 0;
unsolve = 1:runs;

runcap = min(ceil(runs*perc/100)+1, runs);

while true
list = zeros(1,runs);
for run = unsolve
if d == 2
W = Wlist(:,:,:,run);
elseif d == 3
W = Wlist(:,:,:,:,run);
end
[Ebest,tsol] = SA_lattice(betapara,Esol,W,T,1);
if Ebest == Esol
    counter = counter+1;
    unsolve(find(unsolve == run)) = [];
end
list(run) = tsol;
end

tlist = tlist + list;
if counter >= runcap
    break;
end

end

tlist(unsolve) = Inf;

end

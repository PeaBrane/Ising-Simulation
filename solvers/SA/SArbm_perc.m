function [tlist,perc] = SArbm_perc(betapara,Wlist,Elist,T,t0,perc)

runs = size(Wlist,3);

tlist = zeros(1,runs);
unsolve = 1:runs;

runcap = min(ceil(runs*perc/100)+1, runs);
restarts = ceil(T/t0);

counter = 0;
for restart = 1:restarts
list = zeros(1,runs);
for run = unsolve
W = Wlist(:,:,run);
Esol = Elist(run);
[Ebest,tsol] = SArbm(betapara,t0,W,Esol,0);
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
perc = floor( counter/runs*100 );

end

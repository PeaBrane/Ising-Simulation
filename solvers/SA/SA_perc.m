function tlist = SA_perc(betapara,t0,sz,flist,fRBM,fwolff,runs,T,perc)

d = length(sz);
if ~fRBM
[Wlist,Esol] = tiling_ensemble(sz,flist,runs);
Esol = repmat(Esol,[1 runs]);
else
[Wlist,Esol] = rbm_ensemble(sz,flist,runs);
end

flag = 0; restarts = ceil(2^26/T);
runcap = min(ceil(runs*perc/100)+1, runs);
unsol = 1:runs;
tlist = zeros(1,runs);

for restart = 1:restarts
ins = length(unsol);  
temp = zeros(1,ins);
Elist = zeros(1,ins);

parfor in = 1:ins
run = unsol(in);
if fRBM
W = Wlist(:,:,run);
elseif d == 2
W = Wlist(:,:,:,run);
elseif d == 3
W = Wlist(:,:,:,:,run);
end
[Elist(in),temp(in)] = SA(betapara,t0,Esol(in),W,fRBM,fwolff,T,1);
end

list = zeros(1,runs); list(unsol) = temp; tlist = tlist + list;
for in = ins:-1:1
if Elist(in) == Esol(in)
unsol(in) = []; Esol(in) = [];
end
end
if runs-length(unsol) >= runcap
    flag = 1;
    break;
end
end
if flag
tlist(unsol) = Inf;
else
tlist = Inf;
end

end
function tlist = PT_perc(betapara,nr,icm,sz,flist,fRBM,runs,T,perc)

d = length(sz);
[Wlist,Esol] = tiling_ensemble(sz,flist,runs);

tlist = zeros(1,runs);
conf = cell(1,runs);

flag = 0; restarts = ceil(2^35/T);
runcap = min(ceil(runs*perc/100)+1, runs);
unsol = 1:runs;

for restart = 1:restarts
ins = length(unsol);  
temp = zeros(1,ins);
Elist = zeros(1,ins);

parfor in = 1:ins
run = unsol(in);
if d == 2
W = Wlist(:,:,:,run);
elseif d == 3
W = Wlist(:,:,:,:,run);
end
if ~icm
[Elist(in),temp(in),conf{in}] = PT(betapara,nr,Esol,W,T,Inf,fRBM,conf{in},[1 0 0]);
else
[Elist(in),temp(in),conf{in}] = PTI(betapara,nr,Esol,W,T,Inf,conf{in},[1 0 0]);
end
end

list = zeros(1,runs); list(unsol) = temp;
tlist = tlist + list;
for in = ins:-1:1
if Elist(in) == Esol
unsol(in) = []; conf(in) = [];
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
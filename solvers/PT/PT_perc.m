function tlist = PT_perc(betapara,nr,icm,sz,flist,runs,T,perc)

d = length(sz);
[Wlist,Esol] = tiling_ensemble(sz,flist,runs);

nr = ceil(nr);
tlist = zeros(1,runs);
vlist = zeros([sz 2 nr runs]);
rlist = zeros([2 nr runs]);

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
[Elist(in),temp(in)] = PT(betapara,nr,Esol,W,T,1);  
else
v = vlist(:,:,:,:,:,in); r = rlist(:,:,in);
[Elist(in),temp(in),v,r] = PTI(betapara,nr,Esol,W,T,1,v,r);
vlist(:,:,:,:,:,in) = v; rlist(:,:,in) = r;
end
end

list = zeros(1,runs); list(unsol) = temp;
tlist = tlist + list;
for in = ins:-1:1
if Elist(in) == Esol
unsol(in) = [];
if icm
vlist(:,:,:,:,:,in) = [];
rlist(:,:,in) = [];
end
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
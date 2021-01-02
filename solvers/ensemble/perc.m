function [tlist,clist] = perc(vars,algo,sz,flist,fRBM,runs,T,p)

[Wlist,Esol] = ensemble(sz,flist,fRBM,runs);
tlist = zeros(1,runs); clist = zeros(1,runs);
conf = cell(1,runs);

flag = 0; restarts = ceil(2^35/T);
runcap = min(ceil(runs*p/100)+1, runs);
unsol = 1:runs;

for restart = 1:restarts
ins = length(unsol);  
temp1 = zeros(1,ins); temp2 = zeros(1,ins);
Elist = zeros(1,ins);

parfor in = 1:ins
run = unsol(in); cc = conf{in}; W = Wlist{run};
if strcmp(algo,'SA')
[Elist(in),temp1(in),] = SA(vars,Esol(in),W,fRBM,T,Inf,falgo,[1 0 0]);
elseif strcmp(algo,'PT')
[Elist(in),temp1(in),cc] = PT(vars,Esol(in),W,fRBM,T,Inf,cc,[1 0 0]);
elseif strcmp(algo,'ICM')
[Elist(in),temp1(in),cc] = PTI(vars,Esol(in),W,fRBM,T,Inf,cc,[1 0 0]);
elseif strcmp(algo,'mem')
[Elist(in),temp1(in),temp2(in),cc] = mem(vars,Esol(in),W,fRBM,T,Inf,0,cc,[1 0 0]);
end
conf{in} = cc;
end

list1 = zeros(1,runs); list2 = zeros(1,runs);
list1(unsol) = temp1; list2(unsol) = temp2;
tlist = tlist + list1; clist = clist + list2;
for in = ins:-1:1
if abs(Elist(in) - Esol(in))<0.01
unsol(in) = []; conf(in) = []; Esol(in) = [];
end
end
if runs-length(unsol) >= runcap
    flag = 1;
    break;
end
end

if flag
tlist(unsol) = Inf;
clist(unsol) = Inf;
else
tlist = Inf;
clist = Inf;
end

end
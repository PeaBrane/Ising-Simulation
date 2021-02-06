function Ediff = multiple(vars,falgo,sz,flist,fRBM,runs,T)

[falgo,algo,flist,~] = get_suffix(falgo,sz,flist,fRBM,vars);
[Wlist,Esol] = ensemble(sz,flist,fRBM,runs);
Elist = zeros(1,runs);

parfor run = 1:runs
W = Wlist{run}; 
if strcmp(algo,'SA')
Elist(run) = SA(vars,Esol(run),W,fRBM,T,Inf,falgo,[1 0 0]);
elseif strcmp(algo,'PT')
Elist(run) = PT(vars,falgo,Esol(run),W,fRBM,T,Inf,[],[1 0 0]);
elseif strcmp(algo,'ICM')
Elist(run) = PTI(vars,Esol(run),W,fRBM,T,Inf,[],[1 0 0]);
elseif strcmp(algo,'mem')
Elist(run) = mem(vars,falgo,Esol(run),W,fRBM,T,[],[1 0 0]);
end
end
Ediff = Esol-Elist;

end
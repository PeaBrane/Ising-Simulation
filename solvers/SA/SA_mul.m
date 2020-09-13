function Ediff = SA_mul(betapara,t0,sz,flist,fRBM,runs,T,quiet)

Ediff = zeros(1,runs);
parfor run = 1:runs
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol,~] = rbmloops(sz(1),sz(2),100,sz(3),1,0,flist,0.5);
end
[E,~] = SA(betapara,t0,Esol,W,fRBM,T,1);
Ediff(run) = Esol - E;
if ~quiet
   mydot(run,runs,1,1);
end
end

end
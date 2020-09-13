function [Wlist,Elist] = rbm_ensemble(sz,flist,runs)

Wlist = []; Elist = [];
for run = 1:runs 
[W,Esol,~] = rbmloops(sz(1),sz(2),100,sz(3),1,0,flist,0.5);
Wlist = cat(3,Wlist,W);
Elist = [Elist Esol];
end

end
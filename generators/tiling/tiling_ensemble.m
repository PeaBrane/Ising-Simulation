function [Wlist,Esol] = tiling_ensemble(sz,flist,runs)

d = length(sz);

Wlist = [];
for run = 1:runs 
[W,Esol] = tiling(sz,flist);
Wlist = cat(d+2,Wlist,W);
end

end
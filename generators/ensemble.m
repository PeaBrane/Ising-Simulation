function [Wlist,Elist] = ensemble(sz,flist,fRBM,runs)

Wlist = cell(1,runs); Elist = zeros(1,runs);
for run = 1:runs
if ~fRBM
[Wlist{run},Elist(run)] = tiling(sz,flist);  
else
[Wlist{run},Elist(run)] = rbmloops(sz,0.31,flist);
end  
end

end
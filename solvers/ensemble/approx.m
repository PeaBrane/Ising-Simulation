function unsol = approx(vars,falgo,sz,flist,fRBM,runs,T,conf,gap)

if ~gap
    gap = 0.01;
end

Ediff = multiple(vars,falgo,sz,flist,fRBM,runs,T,conf);
unsol = 1 - length(find(Ediff <= gap))/runs;

end
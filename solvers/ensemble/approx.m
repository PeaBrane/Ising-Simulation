function unsol = approx(vars,falgo,sz,flist,fRBM,runs,T,gap)

Ediff = multiple(vars,falgo,sz,flist,fRBM,runs,T);
unsol = 1 - length(find(Ediff <= gap))/runs;

end
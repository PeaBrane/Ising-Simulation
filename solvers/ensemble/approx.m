function unsol = approx(vars,algo,sz,flist,fRBM,runs,T,gap)

Ediff = multiple(vars,algo,sz,flist,fRBM,runs,T);
unsol = 1 - length(find(Ediff <= gap))/runs;

end
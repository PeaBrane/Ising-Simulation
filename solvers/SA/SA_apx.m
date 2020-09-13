function unsol = SA_apx(betapara,t0,sz,flist,fRBM,runs,T,quiet,gap)

Ediff = SA_mul(betapara,t0,sz,flist,fRBM,runs,T,quiet);
unsol = 1 - length(find(Ediff <= gap))/runs;

end
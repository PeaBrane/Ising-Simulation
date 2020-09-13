function var = SA_tune(t0,tlow,tup,sz,flist,fRBM,steps,runs,T,quiet,fSA,fAPX,gap)

n = sz(1); betapara = [0.01 log(n)];

if fAPX
fun = @(t) SA_apx(betapara,t,sz,flist,fRBM,runs,T,1,gap);
else
fun = @(t) mean(SA_mul(betapara,t,sz,flist,fRBM,runs,T,1));
end

if fSA
options = optimoptions(@simulannealbnd,'display','iter','maxiter',steps);
var = simulannealbnd(fun, t0, tlow, tup, options);
else
options = optimset('display','iter','maxiter',steps);
var = fminsearch(fun, t0, options);
end

if ~quiet
fprintf(num2str(var)); fprintf('\n');
end

end
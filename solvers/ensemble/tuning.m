function var = tuning(vars0,varlb,varub,indices,falgo,sz,flist,fRBM,steps,runs,T,monitor,fSA,fAPX,gap)

ll = length(vars0);
varc = vars0(setdiff(1:ll,indices));
varv = vars0(indices);

quiet = monitor(1);

if fAPX
fun = @(var) approx(myinsert(varc,var,indices),falgo,sz,flist,fRBM,runs,T,gap);
else
fun = @(var) mean(multiple(myinsert(varc,var,indices),falgo,sz,flist,fRBM,runs,T));
end

if fSA
options = optimoptions(@simulannealbnd,'display','iter','maxiter',steps);
var = simulannealbnd(fun, varv, varlb, varub, options);
else
options = optimset('display','iter','maxiter',steps);
var = fminsearch(fun, varv, options);
end

if ~quiet
fprintf(num2str(var)); fprintf('\n');
end

end
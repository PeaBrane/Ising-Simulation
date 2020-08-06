function [Nlist,t0list,tlist] = SA_opt(steps,runs,perc,npara,flist,betapara,T,quiet,fsave)

nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

t0list = zeros(1,ins);
tlist = zeros(1,ins);

for in = 1:ins

sz = nmk(in,:);

[Wlist,Esol] = tiling_ensemble(sz,flist,runs);
fun = @(t0) prctile(SA_perc(betapara,t0,Esol,Wlist,T,perc),perc);

% options = optimset('maxiter',steps,'display','off');
% [t0list(in),tlist(in)] = fminsearch(fun, 100, options);
options = optimoptions('fmincon','maxiterations',steps,'display','off');
[t0list(in),tlist(in)] = fmincon(fun, 100, [], [], [], [], 10, 10000, [], options);

if ~quiet
    fprintf('\n');
    fprintf(strcat(num2str(sz),'\n',num2str(t0list(in)),'\n',num2str(tlist(in))));
end

end

if fsave
save('nrlist.mat', 'Nlist', 't0list', 'tlist');
end

end
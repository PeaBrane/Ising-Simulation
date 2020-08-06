function [Nlist,nrlist,tlist] = PT_opt(steps,runs,perc,npara,flist,betapara,T,quiet,fsave)

nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

nrlist = zeros(1,ins);
tlist = zeros(1,ins);

for in = 1:ins

sz = nmk(in,:);

[Wlist,Esol] = tiling_ensemble(sz,flist,runs);
fun = @(nr) prctile(PT_perc(betapara,nr,Esol,Wlist,T,perc),perc);
options = optimoptions('fmincon','maxiterations',steps,'display','off');

[nrlist(in),tlist(in)] = fmincon(fun, 10, [], [], [], [], 2, 50, [], options);

if ~quiet
    fprintf('\n');
    fprintf(strcat(num2str(sz),'\n',num2str(nrlist(in)),'\n',num2str(tlist(in))));
end

end

if fsave
save('nrlist.mat', 'Nlist', 'nrlist', 'tlist');
end

end
function [Nlist,tlist] = SA_scale(runs,perc,npara,flist,betapara,T,quiet,fsave)

nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

tlist = zeros(runs,ins);

parfor in = 1:ins

sz = nmk(in,:);

[Wlist,Esol] = tiling_ensemble(sz,flist,runs);
list = SA_perc(betapara,Esol,Wlist,T,perc);
tlist(:,in) = list.';

if ~quiet
    fprintf('\n');
    fprintf('SA: ');
    fprintf(num2str(sz));
end

end

if fsave
save('SA_scale.mat', 'tlist');
end

end
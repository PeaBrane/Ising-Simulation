function [Nlist,tlist] = PT_scale(nr,icm,npara,flist,fRBM,runs,T,perc,monitor)

nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

tlist = zeros(runs,ins);
quiet = monitor(1); fsave = monitor(3);
if ~icm
    algo = 'PT';
else
    algo = 'ICM';
end

for in = 1:ins

sz = nmk(in,:); N = prod(sz);
betapara = [0.1 log(N)];
list = PT_perc(betapara,nr,icm,sz,flist,fRBM,runs,T,perc);
tlist(:,in) = list.';

if ~quiet
    fprintf('\n');
    fprintf(strcat(algo,': '));
    fprintf(num2str(sz));
end

if fsave
save(strcat(algo,'_scale.mat'),'Nlist','tlist');
end

end

end
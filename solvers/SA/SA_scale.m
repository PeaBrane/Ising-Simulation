function [Nlist,tlist] = SA_scale(nr,npara,flist,fRBM,falgo,runs,T,perc,monitor)

if ~fRBM
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);
else
nmk = repmat([npara(1):2:npara(2)].',[1 2]);
Nlist = sum(nmk,2).';
ins = size(nmk,1);
end

quiet = monitor(1); fsave = monitor(3);
tlist = zeros(runs,ins);

for in = 1:ins

sz = nmk(in,:); N = Nlist(in); betapara = [0.1 log(N)];
list = SA_perc(betapara,nr,sz,flist,fRBM,falgo,runs,T,perc);
tlist(:,in) = list.';

if ~quiet
    fprintf('\n');
    fprintf('SA: ');
    if ~fRBM
    fprintf(num2str(sz));
    else
    fprintf(strcat(num2str(n),'x',num2str(n)));
    end
end

if fsave
save('SA_scale.mat', 'Nlist','tlist');
end

end

end
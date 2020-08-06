function [Nlist,tlist] = PT_scale(betapara,nr,icm,npara,flist,runs,T,perc,quiet,fsave)

nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

tlist = zeros(runs,ins);

for in = 1:ins

sz = nmk(in,:);
list = PT_perc(betapara,nr,icm,sz,flist,runs,T,perc);
tlist(:,in) = list.';

if ~quiet
    fprintf('\n');
    if ~icm fprintf('PT: '); else fprintf('PTI: '); end
    fprintf(num2str(sz));
end

end

if fsave
if ~icm
save('PT_scale.mat', 'Nlist','tlist');
else
save('PTI_scale.mat', 'Nlist','tlist');
end
end

end
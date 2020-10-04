function [Nlist,tlist] = SA_scale(t0,npara,flist,fRBM,falgo,runs,T,perc,quiet,fsave)

if ~fRBM
if length(npara) == 1
nmk = repmat([2:2:npara].',[1 2]);
Nlist = prod(nmk,2).';
ins = size(nmk,1);
else
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);
end
else
nn = 5:5:npara(1);
Nlist = 2*nn;
ins = size(nn,2);
end

tlist = zeros(runs,ins);

for in = 1:ins

if ~fRBM
sz = nmk(in,:);
betapara = [0.1 log(prod(sz))];
else
n = nn(in);
sz = [n n npara(2)];
betapara = 2*n;
end
list = SA_perc(betapara,t0,sz,flist,fRBM,falgo,runs,T,perc);
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
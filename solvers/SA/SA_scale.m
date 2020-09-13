function [Nlist,tlist] = SA_scale(t0,npara,flist,fRBM,runs,T,perc,quiet,fsave)

if ~fRBM
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);
else
nn = 5:5:npara(1);
Nlist = 2*nn;
ins = size(nn,2);
end

tlist = zeros(runs,ins);

for in = 1:ins

if ~fRBM
sz = nmk(in,:);
else
n = nn(in);
sz = [n n npara(2)];
end

list = SA_perc([0.01 log(n)],t0,sz,flist,fRBM,runs,T,perc);
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

end

if fsave
save('SA_scale.mat', 'Nlist','tlist');
end

end
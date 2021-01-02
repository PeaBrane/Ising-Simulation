function [Nlist,tlist,clist] = scalability(vars,npara,flist,fRBM,falgo,runs,T,p,monitor)

[Nlist,nmk] = get_nmk(npara,fRBM);
ins = length(Nlist);

quiet = monitor(1); fsave = monitor(3);
tlist = zeros(runs,ins); clist = zeros(runs,ins);
[algo,fname] = get_suffix(flist,fRBM,falgo);
fname = strcat('scale',fname,'.mat');

for in = 1:ins

sz = nmk(in,:); N = prod(sz);
if ~strcmp(algo,'mem')
vars([1 2]) = [0.1 log(N)];
end
[list1,list2] = perc(vars,algo,sz,flist,fRBM,runs,T,p);
tlist(:,in) = list1.'; clist(:,in) = list2.';

if ~quiet
    fprintf(strcat('\n',algo,': ',num2str(sz)));
end
if fsave
    save(fname, 'Nlist','tlist','clist');
end

end

end
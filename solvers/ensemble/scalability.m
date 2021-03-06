function [Nlist,tlist,clist] = scalability(vars,falgo,npara,flist,fRBM,runs,T,p,thinref,monitor)

[Nlist,nmk] = get_nmk(npara,fRBM);
if ~isempty(thinref)
    [Nlist,nmk] = thin(Nlist,nmk.',thinref,true);
    nmk = nmk.';
end
ins = length(Nlist);

quiet = monitor(1); fsave = monitor(3);
tlist = zeros(runs,ins); clist = zeros(runs,ins);
[falgo,algo,flist,fname] = get_suffix(falgo,npara,flist,fRBM,vars);
fname = strcat('scale',fname,'.mat');

for in = 1:ins

sz = nmk(in,:); N = prod(sz);
if ~strcmp(algo,'mem')
vars([1 2]) = [0.1 log(N)];
end
[list1,list2] = perc(vars,falgo,sz,flist,fRBM,runs,T,p);
tlist(:,in) = list1.'; clist(:,in) = list2.';

if ~quiet
    fprintf(strcat('\n',algo,': ',num2str(sz)));
end
if fsave
    save(fname, 'Nlist','tlist','clist');
end

end

end
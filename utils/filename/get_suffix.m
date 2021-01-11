function [falgo,algo,flist,fname] = get_suffix(falgo,npara,flist,fRBM)

fname = '';
if fRBM
    if isempty(flist)
        flist = 0.23;
    end
    fname = strcat(fname,'_RBM');
end
if length(npara) == 2
    if isempty(flist)
        flist = 11;
    end
    if flist == 1
        fname = strcat(fname,'_jig');
    elseif flist == 11
        fname = strcat(fname,'_dom');
    end
elseif length(npara) == 3
    if isempty(flist)
        flist = [0 0 0 0 1]; 
    end
    fname = strcat(fname,'_til');
end
falgo = [falgo zeros(1,4-length(falgo))];

if falgo(1) == 0
algo = 'SA';
elseif falgo(1) == 1
if ~falgo(2)
algo = 'PT';
else
algo = 'ICM'; 
end
else
algo = 'mem'; 
end
fname = strcat(fname,'_',algo);

if falgo(3)
fname = strcat(fname,'_Wolff');
end
if falgo(4)
fname = strcat(fname,'_KBD','_',num2str(falgo(4)));
end

end
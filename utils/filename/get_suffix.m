function [algo,fname] = get_suffix(flist,fRBM,falgo)

fname = '';
if fRBM
    fname = strcat(fname,'_RBM');
end
if length(flist) == 1
    if flist == 1
        fname = strcat(fname,'_jig');
    elseif flist == 11
        fname = strcat(fname,'_dom');
    end
elseif length(flist) == 5
    fname = strcat(fname,'_til');
end

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
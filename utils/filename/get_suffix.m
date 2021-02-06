function [falgo,algo,flist,fname] = get_suffix(falgo,npara,flist,fRBM,vars)

fname = '';
if fRBM
    if isempty(flist)
        flist = 0.23;
    end
    fname = strcat(fname,'_RBM');
end
if length(npara) == 2
    if isempty(flist)
        flist = 1;
    end
    if any(flist == 'g')
        fname = strcat(fname,'_2dgauss');
    else
        fname = strcat(fname,'_2d',num2str(flist));
    end
elseif length(npara) == 3
    if isempty(flist)
        flist = [0 0 0 0 1]; 
    end 
    if any(flist == 'g')
        fname = strcat(fname,'_3dgauss');
    else
        fname = strcat(fname,'_3d',num2str(flist(end)));
    end
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

if falgo(1) < 2
fname = strcat(fname,num2str(vars(1)),'_',num2str(vars(2)));
end

end
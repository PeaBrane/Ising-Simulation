function [algo,fname] = get_suffix(fRBM,falgo)

fname = '';
if fRBM
    fname = strcat(fname,'_RBM');
end

d = length(falgo);
if d == 1
if ~falgo
fname = strcat(fname,'_PT');
algo = 'PT';
elseif falgo == 1
fname = strcat(fname,'_ICM');  
algo = 'ICM';
elseif falgo == 2
fname = strcat(fname,'_mem');
algo = 'mem';
end
elseif d == 3
algo = 'SA';
if falgo(3)
fname = strcat(fname,'_KBD');
elseif falgo(2)
fname = strcat(fname,'_Wolff');
elseif falgo(1)
fname = strcat(fname,'_SA');
end   
end

end
function [ceind,celist] = my_mat2cell(ind,list)

if ~iscell(list)
    sz = size(list); dim = length(sz);
    if dim == 2
        ll = 1;
    else
        ll = prod(sz(3:dim));
    end
    if dim > 3
        list = reshape(list,[sz(1) sz(2) ll]);
    end
    celist = cell(1,ll);
    for ii = 1:ll
        celist{ii} = list(:,:,ii);
    end
else
    ll = length(list);
    celist = list;
    for ii = 1:ll
    sz = size(celist{ii});
    celist{ii} = reshape(celist{ii},[sz(1) prod(sz(2:end))]); 
    end
end

if ~iscell(ind)
    ceind = cell(1,1); ceind{1,1} = ind; ceind = repmat(ceind,[1 ll]);
else
    ceind = ind; 
end

end
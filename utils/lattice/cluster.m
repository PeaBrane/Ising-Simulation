function list = cluster(v)

n = size(v,1);
m = size(v,2);
k = size(v,3);

clist = find(v);
c = mysample(clist);
[i,j,l] = ind2sub([n m k], c);
c = sub2ind([3*n 3*m 3*k],n+i,m+j,k+l);
N = n*m*k;

V = repmat(v, [3 3 3]);
pixels = bwconncomp(V,6);
pixels = pixels.PixelIdxList;

if isempty(pixels)
    list = 0;
    return;
end

np = length(pixels);
for p = 1:np
    if ismember(c,pixels{p})
        break;
    end
end
list = pixels{p};

indices = reshape(1:N, [n m k]);
indices = repmat(indices, [3 3 3]);
list = indices(list);
list = unique(list);

end
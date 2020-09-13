function list = cluster(v)

sz = size(v);
n = sz(1); m = sz(2); k = sz(3); 
N = n*m*k;

clist = find(v); c = mysample(clist);
if ~c list = 0; return; end

[i,j,l] = ind2sub([n m k], c);
c = sub2ind([2*n 2*m 2*k],i,j,l);

z = zeros(sz);
V = cat(3, [v v; v z], [v z; z z]);
pixels = bwconncomp(V,6);
pixels = pixels.PixelIdxList;

if isempty(pixels)
    list = 0;
    return;
end
for p = 1:length(pixels)
    if ismember(c,pixels{p})
        break;
    end
end
list = pixels{p};

indices = reshape(1:N, [n m k]);
indices = repmat(indices, [2 2 2]);
list = indices(list);
list = unique(list);

end
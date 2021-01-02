function [list,b,bg] = get_sclus(v)

sz = size(v); d = length(sz);
if d == 2
n = sz(1); m = sz(2); N = n*m;
elseif d == 3
n = sz(1); m = sz(2); k = sz(3); N = n*m*k;
end

if ~any(v)
    list = 0; b = 0; bg = 0;
    return; 
end
z = zeros(sz);
if d == 2
V = [v v; v z]; 
pixels = bwconncomp(V,4);
elseif d == 3
V = cat(3, [v v; v z], [v z; z z]);
pixels = bwconncomp(V,6);
end

idx = pixels.PixelIdxList;
if isempty(idx)
    list = 0; b = 0; bg = 0;
    return;
end
for ii = 1:length(idx)
    if d == 2
    indices = reshape(1:N, [n m]); indices = repmat(indices, [2 2]); 
    elseif d == 3
    indices = reshape(1:N, [n m k]); indices = repmat(indices, [2 2 2]);
    end
    idx{ii} = unique(indices(idx {ii}));
end

bsz = cellfun(@length,idx);
[b,bg] = groupcounts(bsz.'); b = b.'; bg = bg.';
ind = cdf_sample(to_cdf(bsz));
list = idx{ind};

end
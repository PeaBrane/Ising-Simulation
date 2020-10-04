function [list,b,bg] = get_sclus(v)

sz = size(v); n = sz(1); m = sz(2); k = sz(3); N = n*m*k;

if ~any(v)
    list = 0; b = 0; bg = 0;
    return; 
end
z = zeros(sz);
V = cat(3, [v v; v z], [v z; z z]);

pixels = bwconncomp(V,6);
idx = pixels.PixelIdxList;
if isempty(idx)
    list = 0; b = 0; bg = 0;
    return;
end
for ii = 1:length(idx)
    indices = reshape(1:N, [n m k]); indices = repmat(indices, [2 2 2]);
    idx{ii} = unique(indices(idx {ii}));
end

bsz = cellfun(@length,idx);
[b,bg] = groupcounts(bsz.'); b = b.'; bg = bg.';
ind = cdf_sample(to_cdf(bsz));
list = idx{ind};

end
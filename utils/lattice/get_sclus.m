function [list,b,bg] = get_sclus(v)

sz = size(v); d = length(sz);
if ~any(v)
    list = 0; b = 0; bg = 0;
    return; 
end

if d == 2
pixels = bwconncomp(v,4);
elseif d == 3
pixels = bwconncomp(v,6);
end

idx = pixels.PixelIdxList;
if isempty(idx)
    list = 0; b = 0; bg = 0;
    return;
end
idx = cellfun(@transpose,periodic(cellfun(@transpose,idx,'uniformoutput',false),sz),'uniformoutput',false);

bsz = cellfun(@length,idx);
[b,bg] = groupcounts(bsz.'); b = b.'; bg = bg.';
ind = cdf_sample(to_cdf(bsz));
list = idx{ind};

end
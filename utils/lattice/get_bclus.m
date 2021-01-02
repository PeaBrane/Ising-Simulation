function [list,b,bg] = get_bclus(w,sw)

sz = size(w); 
if sz == 2
N = sum(sz);
else
N = prod(sz(1:end-1));
end

w = logical(floor( w + rand(sz,'single') ));
G = get_G(w);
[idx,bsz] = conncomp(G);
if isempty(bsz)
    list = 0; b = 0; bg = 0;
    return;
end
[b,bg] = groupcounts(bsz.'); b = b.'; bg = bg.';

if ~sw
ind = cdf_sample(to_cdf(bsz));
list = find(idx == ind);
else
[idx,ind] = discard(idx);
ind = ind(logical(round(rand([1,length(ind)],'single'))));
if isempty(ind)
    list = 0;
    return;
end
idx = repmat(idx,[length(ind) 1]); ind = repmat(ind.',[1 N]);
list = sum(idx==ind,1);
end

end
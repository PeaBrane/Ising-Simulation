function [list,b,bg,cn] = get_bclus(w,sw)

sz = size(w); 
if length(sz) == 2
N = sum(sz);
else
N = prod(sz(1:end-1));
end
cn = zeros([1 N]);

w = logical(floor( w + rand(sz,'single') ));
G = get_G(w);
[idx,bsz] = conncomp(G);
if isempty(bsz)
    list = []; b = 0; bg = [];
    return;
end
[b,bg] = my_gp(bsz.');
cn(idx == idx(1)) = 1;

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
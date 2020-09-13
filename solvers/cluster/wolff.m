function [list,clus] = wolff(v,W,beta,gamma)

w = get_ww(W);
sz = size(w);
w = get_frus(v,w);

w = (logical(floor( 1-exp(-2*beta*w-gamma) + rand(sz) )) & (w>0)) ...
  + (logical(floor( 1-exp(-gamma) + rand(sz) )) & (w<0));

G = get_G(w);
[bins,binsizes] = conncomp(G);
if isempty(binsizes)
    list = 0; clus = 0;
    return;
end
cdf = to_cdf(binsizes);
bin = cdf_sample(cdf);
list = find(bins == bin);
clus = length(list)/prod(sz(1:end-1));

end
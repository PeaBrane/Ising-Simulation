function list = connect(v,w,beta)

sz = size(w);
w = get_frus(v,w);
w = logical(floor( 1-exp(-2*beta*w) + rand(sz) )) & (w>0);
A = get_A(w);
G = graph(A);
[bins,binsizes] = conncomp(G);

cdf = to_cdf(binsizes);
bin = cdf_sample(cdf);

list = find(bins == bin);

end
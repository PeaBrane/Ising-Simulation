function W = loop_c(n,m,scale,frus,nl3,sz)

n1 = ceil(n*sz); m1 = ceil(m*sz);
W = zeros(n,m);

if frus == 0.25
    alpha = scale - 1;
else
    alpha = floor(3*frus/(1-frus)*scale);
end

for loop = 1:nl3

v0 = ceil(n1*rand()); v1 = n1+ceil((n-n1)*rand());
h0 = ceil(m1*rand()); h1 = m1+ceil((m-m1)*rand());
    
W(v0,h0) = W(v0,h0) - alpha;
W(v1,h0) = W(v1,h0) + scale;
W(v0,h1) = W(v0,h1) + scale;
W(v1,h1) = W(v1,h1) + scale;

end
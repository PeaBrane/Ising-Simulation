function H = well(sz,wsz,depth,E)

d = length(sz); N = prod(sz);
w = ones([sz d]);
A = get_A(w);
P = 2*diag(ones(1,N)) - A;

n1 = round((sz(1)-wsz(1))/2); n2 = n1+wsz(1)-1;
m1 = round((sz(2)-wsz(2))/2); m2 = m1+wsz(2)-1;

I = zeros(sz); I(n1:n2,m1:m2) = 1;
V = depth*diag(reshape(I,[1 N]));
H = P + V - diag(E*ones([1 N]));

end
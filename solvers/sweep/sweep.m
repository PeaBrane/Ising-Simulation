function [v,field,E] = sweep(v,W,field,E,beta,fRBM)

if fRBM
    sz = size(W); n = sz(1); m = sz(2);
    h = v(n+1:end); v = v(1:n);
    ratio = -2*beta*field(n+1:end).*h;
    indices = ratio > log(rand([1 m],'single'));
    h(indices) = -h(indices);
    field(1:n) = (W*h.').';
    E = v*W*h.';
    ratio = -2*beta*field(1:n).*v;
    indices = ratio > log(rand([1 n],'single'));
    v(indices) = -v(indices);
    field(n+1:end) = v*W;
    E = max([E v*W*h.']);   
    v = [v h];
    return;
end

sz = size(v); d = length(sz);

if d == 2

n = sz(1); m = sz(2);
randlist = ceil(log(rand(sz,'single'))/beta);
i1list = circshift(1:n, 1); i2list = circshift(1:n, -1);
j1list = circshift(1:m, 1); j2list = circshift(1:m, -1);

for i = 1:n
i1 = i1list(i); i2 = i2list(i);
for j = 1:m
j1 = j1list(j); j2 = j2list(j);
    
    v0 = v(i,j);
    if -2*field(i,j)*v0 >= randlist(i,j)
        v(i,j) = -v0;
        E = E - 2*field(i,j)*v0;
        field(i1,j) = field(i1,j) - 2*v0*W(i,j,1);
        field(i2,j) = field(i2,j) - 2*v0*W(i,j,2);
        field(i,j1) = field(i,j1) - 2*v0*W(i,j,3);
        field(i,j2) = field(i,j2) - 2*v0*W(i,j,4);
    end
    
end
end
    
elseif d == 3

n = sz(1); m = sz(2); k = sz(3);
randlist = ceil(log(rand(sz,'single'))/beta);

i1list = circshift(1:n, 1); i2list = circshift(1:n, -1);
j1list = circshift(1:m, 1); j2list = circshift(1:m, -1);
l1list = circshift(1:k, 1); l2list = circshift(1:k, -1);

for i = 1:n
i1 = i1list(i); i2 = i2list(i);
for j = 1:m
j1 = j1list(j); j2 = j2list(j);
for l = 1:k
l1 = l1list(l); l2 = l2list(l);
    
    v0 = v(i,j,l);
    
    if -2*field(i,j,l)*v0 >= randlist(i,j,l)
        v(i,j,l) = -v0;
        E = E - 2*field(i,j,l)*v0;
        field(i1,j,l) = field(i1,j,l) - 2*v0*W(i,j,l,1);
        field(i2,j,l) = field(i2,j,l) - 2*v0*W(i,j,l,2);
        field(i,j1,l) = field(i,j1,l) - 2*v0*W(i,j,l,3);
        field(i,j2,l) = field(i,j2,l) - 2*v0*W(i,j,l,4);
        field(i,j,l1) = field(i,j,l1) - 2*v0*W(i,j,l,5);
        field(i,j,l2) = field(i,j,l2) - 2*v0*W(i,j,l,6);
    end
    
end
end
end

end

end
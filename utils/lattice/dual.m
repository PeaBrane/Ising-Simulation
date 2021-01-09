function s = dual(v,shade,map)

sz = size(v); n = sz(1); m = sz(2);
if ~map
    n = n*2; s = zeros(n,m);
else
    s = zeros(n/2,m); 
end

for i = 1:n/2
for j = 1:m
ii = mod(i+j-2+shade,n)+1; jj = mod(i-j,m)+1;
if ~map
s(ii,jj) = v(i,j); 
else
s(i,j) = v(ii,jj);    
end
end
end

end
function s = dual(v,shade)

sz = size(v); n = sz(1); m = sz(2);
n1 = n/2; m1 = m/2; s = zeros(n1,m1);

for i = 1:n1
for j = 1:m1
ii = mod(shade+i+j-1,n1)+1; jj = mod(i-j-1,m1)+1;
s(i,j) = v(ii,jj);    
end
end

end
function [w,E,cost] = tiling_2d(n,m,flist)

if flist == 10
    w = ones(n,m,2);
    E = sum(w(:));
    cost = (sum(abs(w(:)))-E)/2;
    return;
end

check = checkerboard([n m],0);
wp = ones(n,m,4);
if flist == 11
    wp(1:2:n-1,:,4) = -1; wp(2:2:n,:,2) = -1;
    w = wp_to_w(wp,check,0);
    E = sum(w(:));
    cost = (sum(abs(w(:)))-E)/2;
    return;
end

for i = 1:n
for j = 1:m
if ~mod(i+j,2) && floor(flist+rand())
    wp(i,j,ceil(4*rand())) = -1;
end
end
end
w = wp_to_w(wp,check,0);
E = sum(w(:));
cost = (sum(abs(w(:)))-E)/2;

end
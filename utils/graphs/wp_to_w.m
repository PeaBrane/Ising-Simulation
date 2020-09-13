function w = wp_to_w(wp,check,map)

sz = size(wp); sz = sz(1:end-1); d = length(sz);
w = zeros([sz d]);
if numel(check) == 1
    check = checkerboard(sz,check);
end


if d == 2
n = sz(1); m = sz(2);
n1 = circshift(1:n,1); m1 = circshift(1:m,1);
n2 = circshift(1:n,-1); m2 = circshift(1:m,-1);    
if ~map
wp = wp.*repmat(check,[1 1 4]);
w = wp(:,:,[1 2]) + cat(3,wp(:,m1,3),wp(n1,:,4));
else
w = cat(3,wp,wp(:,m2,1),wp(n2,:,2));
w = w.*repmat(check,[1 1 4]);
end
    
elseif d == 3
    
n = sz(1); m = sz(2); k = sz(3);
i1list = circshift(1:n,-1); j1list = circshift(1:m,-1); l1list = circshift(1:k,-1);
for i = 1:n
for j = 1:m
for l = 1:k
    
    if (mod(i,2) == 1 && mod(j,2) == 1 && mod(l,2) == 1) || (mod(i,2) == 0 && mod(j,2) == 0 && mod(l,2) == 0)
        i1 = i1list(i); j1 = j1list(j); l1 = l1list(l);
        p = wp(i,j,l,:);
        p = reshape(p,[1 1 1 12]);
        w(i,j,l,:) = p([1 4 9]);
        w(i1,j,l,[2 3]) = p([2 10]);
        w(i,j1,l,[1 3]) = p([3 12]);
        w(i,j,l1,[1 2]) = p([5 8]);
        w(i1,j1,l,3) = p(11);
        w(i1,j,l1,2)= p(6);
        w(i,j1,l1,1) = p(7);
    end
    
end
end
end
    
end

end
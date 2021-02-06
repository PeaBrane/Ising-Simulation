function w = wp_2d(wp,check,map)

sz = size(wp); sz = sz(1:end-1); n = sz(1); m = sz(2);

n1 = circshift(1:n,1); m1 = circshift(1:m,1);
n2 = circshift(1:n,-1); m2 = circshift(1:m,-1);   

if ~map
wp = wp.*repmat(check,[1 1 4]);
w = wp(:,:,[1 2]) + cat(3,wp(:,m1,3),wp(n1,:,4));
else
w = cat(3,wp,wp(:,m2,1),wp(n2,:,2));
w = w.*repmat(check,[1 1 4]);
end

end
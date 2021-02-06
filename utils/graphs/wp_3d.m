function w = wp_3d(wp,check,map)

sz = size(wp); sz = sz(1:end-1); fd = class(wp);
n = sz(1); m = sz(2); k = sz(3);

n1 = circshift(1:n,1); m1 = circshift(1:m,1); k1 = circshift(1:k,1);
n2 = circshift(1:n,-1); m2 = circshift(1:m,-1); k2 = circshift(1:k,-1);

if ~map
wp = wp.*check;
w = wp(:,:,:,[1 2 3]) + ...
    cat(4,wp(:,m1,k1,4),wp(n1,:,:,[5 6])) + ...
    cat(4,wp(:,m1,:,7),wp(n1,:,k1,8),wp(:,m1,:,9)) + ...
    cat(4,wp(:,:,k1,[10 11]),wp(n1,m1,:,12));

else
w = zeros([sz 12],fd);
w(:,:,:,[1 2 3]) = wp;
w(:,:,:,[5 6]) = wp(n2,:,:,[2 3]);
w(:,:,:,[7 9]) = wp(:,m2,:,[1 3]);
w(:,:,:,[10 11]) = wp(:,:,k2,[1 2]);
w(:,:,:,4) = wp(:,m2,k2,1);
w(:,:,:,8) = wp(n2,:,k2,2);
w(:,:,:,12) = wp(n2,m2,:,3);
w = w.*check;
end

end
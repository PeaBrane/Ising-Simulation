function W = get_W(w)

sz = size(w); fd = class(w);
dim = length(sz)-1;

if dim == 2

n = sz(1); m = sz(2);
W = zeros([n m 4],fd);
W(:,:,[2 4]) = w;
W(:,:,1) = circshift(w(:,:,1),1,1);
W(:,:,3) = circshift(w(:,:,2),1,2);

elseif dim == 3
   
n = sz(1); m = sz(2); k = sz(3);
W  = zeros([n m k 6],fd);
W(:,:,:,[2 4 6]) = w;
% n1 = circshift(1:n,1); m1 = circshift(1:m,1); k1 = circshift(1:k,1);
% W(:,:,:,[1 3 5]) = cat(4,w(n1,:,:,1),w(:,m1,:,2),w(:,:,k1,3));
W(:,:,:,1) = circshift(w(:,:,:,1),1,1);
W(:,:,:,3) = circshift(w(:,:,:,2),1,2);
W(:,:,:,5) = circshift(w(:,:,:,3),1,3);
    
else
    
    fprintf('Error');
    return;
    
end

end
function V = get_V(v)

sz = size(v);
dim = length(sz);

if dim == 2

n = sz(1); m = sz(2);
V = zeros(n,m,4);
V(:,:,1) = circshift(v,1,1);
V(:,:,2) = circshift(v,-1,1);
V(:,:,3) = circshift(v,1,2);
V(:,:,4) = circshift(v,-1,2);
    
elseif dim == 3
    
n = sz(1); m = sz(2); k = sz(3);
V = zeros(n,m,k,6);
V(:,:,:,1) = circshift(v,1,1);
V(:,:,:,2) = circshift(v,-1,1);
V(:,:,:,3) = circshift(v,1,2);
V(:,:,:,4) = circshift(v,-1,2);
V(:,:,:,5) = circshift(v,1,3);
V(:,:,:,6) = circshift(v,-1,3);

else
    
    fprintf('Error');
    return;
    
end

end
function idx = periodic_3d(idx,sz)

n = sz(1); m = sz(2); k = sz(3); N = prod(sz); indices = int16(reshape(1:N,sz));
b1 = [reshape(indices(:,:,1),[1 n*m]) reshape(indices(:,:,k),[1 n*m])];
b2 = [reshape(indices(:,1,:),[1 n*k]) reshape(indices(:,m,:),[1 n*k])];
b3 = [reshape(indices(1,:,:),[1 m*k]) reshape(indices(n,:,:),[1 m*k])];
idx = intersect_diff(intersect_diff(intersect_diff(idx,b1,[n m k]),b2,[n m]),b3,n);

end
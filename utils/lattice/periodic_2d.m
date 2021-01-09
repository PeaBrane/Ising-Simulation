function idx = periodic_2d(idx,sz)

n = sz(1); m = sz(2); N = prod(sz); indices = reshape(1:N,sz);
b1 = [indices(:,1).' indices(:,m).'];
b2 = [indices(1,:) indices(n,:)];
idx = intersect_diff(intersect_diff(idx,b1,[n m]),b2,n);

end
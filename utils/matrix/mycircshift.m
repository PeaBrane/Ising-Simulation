function mat = mycircshift(mat,kk,dim)

sz = size(mat);

if dim == 1
    n = sz(1);
    indices = 1:n; indices1 = mymod(indices-kk,n);
    mat = mat(indices1,:,:);
elseif dim == 2
    m = sz(2);
    indices = 1:m; indices1 = mymod(indices-kk,m);
    mat = mat(:,indices1,:);
elseif dim == 3
    k = sz(3);
    indices = 1:k; indices1 = mymod(indices-kk,k);
    mat = mat(:,:,indices1);
else
   fprintf('Error');
   return;
end

end
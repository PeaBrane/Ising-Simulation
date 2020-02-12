function list = gen_indices(sz)

dim = length(sz);

if dim == 2
    n = sz(1); m = sz(2);
    list = repmat([1:n].',[1 m]) + n*repmat([0:m-1],[n 1]);
elseif dim == 3
    n = sz(1); m = sz(2); k = sz(3);
    list = repmat(reshape([1:n],[n 1 1]),[1 m k]) ...
         + repmat(reshape([0:m-1],[1 m 1]),[n 1 k])*n ...
         + repmat(reshape([0:k-1],[1 1 k]),[n m 1])*n*m;
else
    fprintf('Error');
    return;
end

end
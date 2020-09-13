function w = get_ww(W)

sz = size(W);
dim = length(sz)-1;

if dim == 2
w = W(:,:,[2 4]);
elseif dim == 3
w = W(:,:,:,[2 4 6]);
else   
    fprintf('Error');
    return;    
end

end
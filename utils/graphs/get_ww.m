function w = get_ww(W)

sz = size(W);
d = length(sz)-1;

if d == 1
w = W;
elseif d == 2
w = W(:,:,[2 4]);
elseif d == 3
w = W(:,:,:,[2 4 6]);
else   
    fprintf('Error');
    return;    
end

end
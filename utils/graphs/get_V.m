function V = get_V(v)

sz = size(v);
d = length(sz);

if d == 2

V  = cat(3, circshift(v,1,1), circshift(v,-1,1), ...
            circshift(v,1,2), circshift(v,-1,2));
    
elseif d == 3
    
V  = cat(4, circshift(v,1,1), circshift(v,-1,1), ...
            circshift(v,1,2), circshift(v,-1,2), ...
            circshift(v,1,3), circshift(v,-1,3));

else
    
    fprintf('Error');
    return;
    
end

end
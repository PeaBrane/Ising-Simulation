function w = get_frus(v,w)

d = length(size(w))-1;

if d == 2
    v1 = circshift(v,-1,1);
    v2 = circshift(v,-1,2);
    w = repmat(v,[1 1 2]).*cat(3,v1,v2).*w;
elseif d == 3
    v1 = circshift(v,-1,1);
    v2 = circshift(v,-1,2);
    v3 = circshift(v,-1,3);
    w = repmat(v,[1 1 1 3]).*cat(4,v1,v2,v3).*w;
else
    fprintf('Dimension error.');
end

end
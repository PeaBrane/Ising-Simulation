function w = get_frus(v,w)

sz = size(w); d = length(sz)-1;

if d == 1
    n = sz(1);
    w = (v(1:n).'*v(n+1:end)).*w;
elseif d == 2
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
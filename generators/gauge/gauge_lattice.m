function [w,v] = gauge_lattice(w)

sz = size(w); sz = sz(1:end-1);
dim = length(sz);

v = -1+2*round(rand(sz,'single'));

if dim == 2
    
    v1 = circshift(v,-1,1); v2 = circshift(v,-1,2);
    w = w.*cat(3,v1,v2).*repmat(v,[1 1 2]);
    
elseif dim == 3
    
    v1 = circshift(v,-1,1); v2 = circshift(v,-1,2); v3 = circshift(v,-1,3);
    w = w.*cat(4,v1,v2,v3).*repmat(v,[1 1 1 3]);
    
end

end
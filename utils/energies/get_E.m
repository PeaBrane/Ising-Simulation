function [V,field,E] = get_E(v,W)

dim = length(size(v));
V = get_V(v);

v0 = sign(v); V0 = sign(V);

if dim == 2
field = sum(W.*V0,3);
elseif dim == 3
field = sum(W.*V0,4);
else
    fprintf('Error');
end

E2 = field.*v0;
E = sum(E2(:))/2;

end
function [V,field,lfield,E,C] = get_E(v,W)

sz = size(v); d = length(sz);
V = get_V(v); 
lfield = W.*V; 
% C = 0.5*(1-lfield.*repmat(v, [ones(1,d) 2*d]));
C = 1 - 0.5*(repmat(v, [ones(1,d) 2*d]).^2 + V.^2);

v0 = sign(v); V0 = sign(V);
% v0 = randround(v); V0 = get_V(v0);
field = sum(W.*V0,d+1);
E2 = field.*v0;
E = sum(E2(:))/2;

end
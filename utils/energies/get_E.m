function [V,field,lfield,E,C] = get_E(v,W,fRBM)

if ~fRBM
sz = size(v); d = length(sz);
V = get_V(v); 
lfield = W.*V; 
C = repmat(v,[ones(1,d) 2*d]).*lfield + 1;

v0 = sign(v); V0 = sign(V);
% v0 = randround(v); V0 = randround(V);
field = sum(W.*V0,d+1);
E2 = field.*v0;
E = sum(E2(:))/2;

else
V = 0; lfield = 0;
sz = size(W); n = sz(1); m = sz(2);
vv = v(1:n); hh = v(n+1:n+m);
field = [(W*hh.').' vv*W];
E = sign(vv)*W*sign(hh.');
C = (vv.'*hh).*W;
    
end

end
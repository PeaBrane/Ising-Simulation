function [V,field,lfield,E,C] = get_E(v,W,fRBM)

if ~fRBM
sz = size(v); d = length(sz);
V = get_V(v); 
lfield = W.*V; 
C = repmat(v,[ones(1,d) 2*d]).*lfield + 1;

v0 = sign(v); V0 = sign(V);
field = int16(sum(W.*V0,d+1));
E2 = field.*v0;
E = int16(sum(E2(:))/2);

else
sz = size(W); n = sz(1); m = sz(2);
V = v;
vv = v(1:n); hh = v(n+1:n+m);
vv0 = sign(vv); hh0 = sign(hh);

lfield = [(W*hh.').' vv*W];
field = [(W*hh0.').' vv0*W];

E = vv0*W*hh0.';
C = (vv.'*hh).*W + 1;
    
end

end
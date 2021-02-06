function [E,C,G] = get_L(v,X,W,fp,check,alpha,beta,fRBM)

if ~fRBM
d = length(size(v));
V = get_V(v); v0 = sign(v); V0 = sign(V);
E = double(sum(v0.*sum(V0.*W,d+1),'all')/2);
lfield = W.*V; 

if ~fp
C = v.*lfield+1;
else
C = wp_to_w(get_ww(v.*lfield),check,1)+1;
X = get_W(wp_to_w(X,check,0));
end
G = alpha*sum(lfield,d+1) - 2*beta*sum(X,d+1).*v;
else
[~,~,lfield,E,C] = get_E(v,W,true); 
G = alpha*lfield - 2*beta*[sum(X,2).' sum(X,1)].*v;
end

end
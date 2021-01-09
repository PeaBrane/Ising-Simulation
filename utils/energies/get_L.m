function [E,C,G] = get_L(v,X,W,alpha,beta,fRBM)

if ~fRBM
d = length(size(v));
[~,~,lfield,E,C] = get_E(v,W,false);
G = alpha*sum(lfield,d+1) -2*beta*sum(X,d+1).*v;
else
[~,~,lfield,E,C] = get_E(v,W,true); 
G = alpha*lfield - 2*beta*[sum(X,2).' sum(X,1)].*v;
end

end
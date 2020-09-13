function [E,C,G] = get_L(v,X,w,W,alpha,beta,fRBM)

if ~fRBM
d = length(size(v));
[~,~,lfield,E,C] = get_E(v,w,W,false);
G = alpha*sum(lfield,d+1) -2*beta*sum(X,d+1).*v;
else
[~,field,~,E,C] = get_E(v,w,W,true); 
G = alpha*field - 2*beta*[sum(X,2).' sum(X,1)].*v;
end

end
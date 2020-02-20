function [Wlist,Elist] = rbm_ensemble(n,m,scale,rho,cloops,vers,frus,sz,runs)
% generate an (n x m) RBM instance

Wlist = zeros(n,m,runs); Elist = zeros(1,runs);
for run = 1:runs
    [W,Esol,~] = rbmloops(n,m,scale,rho,cloops,vers,frus,sz);
    Wlist(:,:,run) = W;
    Elist(run) = Esol;
end

end
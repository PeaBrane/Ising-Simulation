function [w,E,cost] = rbmloops(n,m,scale,rho,cloops,vers,frus,sz)
% generate an (n x m) RBM instance

n_loops = ceil(n*rho);
nl1 = ceil(n_loops/(2+cloops)); % number of left loops
nl2 = ceil(n_loops/(2+cloops)); % number of upper loops
nl3 = ceil(n_loops*cloops/(2+cloops)); % number of center loops
if cloops == Inf
    nl1 = 0; nl2 = 0;
    nl3 = n_loops;
end

if vers == 0
    W = loop_rand(n,m,scale,frus,n_loops); % random loop algorithm
elseif vers == 1
    W = loop_struc(n,m,scale,frus,nl1,nl2,nl3,sz); % structured loop algorithm
else
    fprintf('Version Error');
    return;
end

E = sum(W(:)); % planted RBM energy
cost = (sum(abs(W(:))) - E)/2; % planted optimal cost
[~,~,w] = gauge_rbm(n,m,W); % randomly gauge the weight matrix

end
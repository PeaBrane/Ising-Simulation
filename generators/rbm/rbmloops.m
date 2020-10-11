function [W,Esol,cost] = rbmloops(sz,rho,frus)
% generate an (n x m) RBM instance

n = sz(1); m = sz(2); scale = 1; vers = 0; cloops = Inf;
n_loops = ceil(n*rho);
nl1 = ceil(n_loops/(2+cloops)); % number of left loops
nl2 = ceil(n_loops/(2+cloops)); % number of upper loops
nl3 = ceil(n_loops*cloops/(2+cloops)); % number of center loops
if cloops == Inf
    nl1 = 0; nl2 = 0;
    nl3 = n_loops;
end

if frus == 11
    W = normrnd(0,scale,[n m]); Esol = 0; cost = 0;
    return;
end

if vers == 0
    W = loop_rand(n,m,scale,frus,n_loops); % random loop algorithm
elseif vers == 1
    W = loop_struc(n,m,scale,frus,nl1,nl2,nl3,0.5); % structured loop algorithm
else
    fprintf('Version Error');
    return;
end

Esol = sum(W(:)); % planted RBM energy
cost = (sum(abs(W(:))) - Esol)/2; % planted optimal cost
[~,~,W] = gauge_rbm(n,m,W); % randomly gauge the weight matrix

end
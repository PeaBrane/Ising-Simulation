function [w,E,cost] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz)
% generate an (n x m) RBM instance

nl1 = ceil(n_loops/(2+loop_ratio)); % number of left loops
nl2 = ceil(n_loops/(2+loop_ratio)); % number of upper loops
nl3 = ceil(n_loops*loop_ratio/(2+loop_ratio)); % number of center loops
if loop_ratio == Inf
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
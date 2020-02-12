function [v,h,W] = gauge_rbm(n,m,W)
% gauge the weight matrix such that
% {v,h} is the ground state

% randomly selects half of the visible spins and half of the hidden spins
% to perform the gauge operation
vlist = randsample(1:n,ceil(n/2));
hlist = randsample(1:m,ceil(m/2));
W(vlist,:) = -W(vlist,:);
W(:,hlist) = -W(:,hlist);
v = ones(1,n); v(vlist) = -1;
h = ones(1,m); h(hlist) = -1;

end
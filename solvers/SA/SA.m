function [Ebest,tt,state] = SA(vars,Esol,W,fRBM,T,tw,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); d = length(sz); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); d = Inf; N = n+m;
end

t0 = 2^10; restarts = ceil(T/t0);
T = T*nr; betalist = linspace(betapara(1),betapara(2),t0);

Ebest = 0; flag = 0;

% initialization
if ~fRBM
v = double(-1+2*round(rand(sz,'single')));
else
v = double(-1+2*round(rand([1 N],'single')));
end
[~,field,~,E,~] = get_E(v,W,fRBM);

for restart = 1:restarts
for t = 1:t0
beta = betalist(t);    

% sweep
[v,field,E] = sweep(v,W,field,E,beta,fRBM);

% terminate
if E > Ebest
    Ebest = E;
    if abs(Ebest-Esol)<0.01
        flag = 1;
        break;
    end
end
   
% display
if ~quiet
mydot((restart-1)*t0+t,restarts*t0,1,1);
end
    
end
if flag
    break;
end
end
tt = (restart-1)*t0+t;
end
function [Ebest,t,clus] = SA(betapara,t0,Esol,W,fRBM,fwolff,fkbd,T,quiet)

t0 = ceil(2^t0);
Ebest = 0;
clus = [];
flag = 0;
if t0 < 1 || t0 > T
    Ebest = -Esol;
    t = T;
    return;
end

if ~fRBM
sz = size(W); sz = sz(1:end-1); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); w = W/max(abs(W(:)));
end
restarts = ceil(T/t0);

betalist = linspace(betapara(1),betapara(2),t0);

for restart = 1:restarts
if ~fRBM
v = -1+2*round(rand(sz));
else
v = -1+2*round(rand(1,n)); h = -1+2*round(rand(1,m));
the = v*w;
randlist = log(rand(t0,n+m));
end
[~,field,~,E,~] = get_E(v,W,W,fRBM);

for dt = 1:t0
    
beta = betalist(dt);

if ~fRBM
[v, field, E] = sweep_lattice(v,W,field,E,beta);
else
hlist = randlist(dt,n+1:n+m);
ratio = -2*beta*the.*h;
indices = ratio > hlist;
h(indices) = -h(indices);
phi = (w*h.').';
E = v*W*h.';
vlist = randlist(dt,1:n);
ratio = -2*beta*phi.*v;
indices = ratio > vlist;
v(indices) = -v(indices);
the = v*w;
E = max([E v*W*h.']);
end
if fwolff
[inds,cl] = wolff(v,W,beta,0);
v(inds.') = -v(inds.');
[~,field,~,E,~] = get_E(v,W,W,false);
clus = [clus cl];
end
if fkbd
[inds,cl] = kbd(v,W,beta,1);
v(inds.') = -v(inds.');
[~,field,~,E,~] = get_E(v,W,W,false);
clus = [clus cl];
end

if E > Ebest
    Ebest = E;
    if Ebest == Esol
        flag = 1;
        break;
    end
end
    
if ~quiet
mydot((restart-1)*t0+dt,restarts*t0,1,1);
end
    
end

if flag
    break;
end

end

t = (restart-1)*t0 + dt;

end
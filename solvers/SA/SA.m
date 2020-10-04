function [Ebest,t,state] = SA(betapara,nr,Esol,W,T,tw,fRBM,falgo,monitor)

% load
if ~fRBM
sz = size(W); sz = sz(1:end-1); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); w = W/max(abs(W(:)));
end
betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
Ebest = 0; flag = 0;

% initialization
if ~fRBM
v = -1+2*round(rand(sz));
else
v = -1+2*round(rand(1,n)); h = -1+2*round(rand(1,m));
the = v*w;
randlist = log(rand(t0,n+m));
end
[~,field,~,E,~] = get_E(v,W,W,false);

% monitor
quiet = monitor(1); record = monitor(2);
fsweep = falgo(1); fwolff = falgo(2); fkbd = falgo(3);
state = struct;
state.E = zeros(1,T-tw,bl);
state.lap = zeros(1,T-tw,bl);
state.clus = zeros(1,N,bl);
if fkbd
    check = checkerboard(sz,0);
end

for bi = 1:bl
beta = betalist(bi);
for t = 1:T

% sweep
if fsweep
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
end

% wolff
if fwolff
[list,b,bg] = wolff(v,W,beta,0);
v(list.') = -v(list.');
[~,field,~,E,~] = get_E(v,W,W,false);
state.clus(:,bg,bi) = state.clus(:,bg,bi)+b;
end

% kbd
if fkbd
[list,b,bg] = kbd(v,W,beta,1,check);
v(list.') = -v(list.');
[~,field,~,E,~] = get_E(v,W,W,false);
state.clus(:,bg,bi) = state.clus(:,bg,bi)+b;
end

% record
if t == tw
    v0 = v;
end
if t > tw
    state.E(1,t-tw,bi) = (Esol-E)/Esol/N;
    state.lap(1,t-tw,bi) = sum(v0.*v,[1 2 3])/N;
end

% terminate
if E > Ebest
    Ebest = E;
    if (Ebest>=Esol) && ~record
        flag = 1;
        break;
    end
end
   
% display
if ~quiet
mydot((bi-1)*T+t,bl*T,1,1);
end
    
end
if flag
    break;
end
end
t = (bi-1)*T + t;
end
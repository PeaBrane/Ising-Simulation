function [Ebest,t,state] = SA(vars,Esol,W,fRBM,T,tw,falgo,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); N = n+m;
end
if record
betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
else
t0 = 2^10; betalist = geoseries(betapara(1),betapara(2),t0); bl = 1;
end
Ebest = 0; flag = 0;

% initialization
if ~fRBM
v = -1+2*round(rand(sz));
else
v = -1+2*round(rand(1,n+m));
end
[~,field,~,E,~] = get_E(v,W,fRBM);

% monitor
fsweep = ~falgo(1); fwolff = falgo(3); fkbd = falgo(4);
if record
state = struct;
state.tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(state.tlist);
state.E = zeros(1,bl);
state.lap = zeros(1,recs,bl);
state.clus = zeros(1,N,bl);
else
state = 0; 
end
if fkbd
    check = checkerboard(sz,0);
end

for bi = 1:bl
rec = 0;
for t = 1:T
if record
beta = betalist(bi);
else
beta = betalist(mod(t-1,t0)+1);
end

% sweep
if fsweep
[v,field,E] = sweep(v,W,field,E,beta,fRBM);
end

% wolff
if fwolff
[list,b,bg] = wolff(v,W,beta,0);
v(list.') = -v(list.');
[~,field,~,E,~] = get_E(v,W,fRBM);
state.clus(:,bg,bi) = state.clus(:,bg,bi)+b;
end

% kbd
if fkbd
[list,b,bg] = kbd(v,W,beta,1,check);
v(list.') = -v(list.');
[~,field,~,E,~] = get_E(v,W,fRBM);
state.clus(:,bg,bi) = state.clus(:,bg,bi)+b;
end

% record
if record
if t == tw
    v0 = v;
end
if t > tw
state.E(1,bi) = state.E(1,bi) + (Esol-E)/Esol/N;
if ismember(t-tw,state.tlist)
rec = rec+1;
if ~fRBM
state.lap(1,rec,bi) = sum(v0.*v,'all')/N;
else
state.lap(1,rec,bi) = sum((v0(1:n).'*v0(n+1:end)).*(v(1:n).'*v(n+1:end)) ,'all')/(n*m);
end
end
end
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
if record
state.E = state.E/(T-tw);
end
end
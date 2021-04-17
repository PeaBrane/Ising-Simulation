function [Ebest,tt,state] = SA(vars,Esol,W,fRBM,T,tw,monitor)

% load
betapara = vars(1:2);
quiet = monitor(1); record = monitor(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); W = int16(W);
d = length(sz); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); W = W/max(abs(W(:)));
d = Inf; N = n+m;
end

t0 = N; restarts = ceil(T/t0);
betalist = linspace(betapara(1),betapara(2),t0);

Ebest = int16(0); 
flag = 0;

ttlist = unique(round(geoseries(1,(T),10*round(log2(T))))); rrecs = length(ttlist);
state.Et = zeros([1 rrecs]); state.Eb = zeros([1 rrecs]);

% initialization
if ~fRBM
v = int16(-1+2*round(rand(sz,'single')));
else
v = -1+2*round(rand([1 N],'single'));
end
[~,field,~,E,~] = get_E(v,W,fRBM);

tt = 0;
for restart = 1:restarts
for t = 1:t0
beta = betalist(t);
tt = (restart-1)*t0+t;

% sweep
[v,field,E] = sweep(v,W,field,E,beta,fRBM);

% terminate
[Ebest,flag] = breakout(E,Ebest,Esol,record);

% record
if ismember(tt,ttlist) 
rrec = find(ttlist == tt,1,'first');
state.Et(rrec) = double(Esol-E)/N;
state.Eb(rrec) = -double(Ebest)/N;
end

% display
if ~quiet
mydot((restart-1)*t0+t,restarts*t0,1,1);
end

if flag break; end
end
if flag break; end
end
end
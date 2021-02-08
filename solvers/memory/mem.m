function [Ebest,tt,step,conf,state] = mem(vars,falgo,Esol,W,fRBM,T,conf,monitor)

% load
quiet = monitor(1); record = monitor(2);
fp = falgo(1)==2.5; fd = falgo(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); 
d = length(sz); N = prod(sz);
alpha = vars(1); beta = vars(2); gamma = vars(3); delta = vars(4); zeta = vars(5);
xini = vars(6); t0 = floor(2^vars(7)); dtlist = 2.^[-5 vars(8)];
else
sz = size(W); n = sz(1); m = sz(2); 
d = Inf; N = sum(sz);
alpha = vars(1); beta = vars(2); gamma = vars(3); delta = vars(4); zeta = vars(5);
xini = vars(6); t0 = floor(2^vars(7)); dtlist = 2.^[-5 vars(8)];
end
if ~fd
    W = single(W);
end
dd = 8*d-12;

if xini < 0 || t0 <= 0
    Ebest = -Esol; tt = Inf; state = 0;
    return;
end
dt0 = 2^-5; nt = round(t0/dt0); nr = ceil(T/t0); T = t0*nr;

% initialize
check = checkerboard(sz,0);
if isempty(conf)
if ~fRBM
v = double(-1+2*round(rand(sz,'single')));
if ~fp
X = xini*ones([sz 2*d]);
Y = ones([sz 2*d]);
else
X = xini*ones([sz dd]).*check;
Y = check;
zeta = zeta*check;
end
else
v = double(-1 + 2*round(rand([1 n+m],'single')));
X = xini*ones([n m],'single');
X = double(X.*logical(W)); 
Y = double(logical(W));
end
else
v = conf{1}; X = conf{2}; Y = conf{3};
end
if ~fd
v = single(v); X = single(X); Y = single(Y);
end

% monitor
Ebest = 0; flag = 0;
if record
state = struct;
ttlist = unique(round(geoseries(1,(T),10*round(log2(T))))); rrecs = length(ttlist);
rlist = unique(round(geoseries(1,nr,10*round(log2(nr))))); nrl = length(rlist);
state.tlist = rlist*t0;

state.Et = zeros([1 rrecs]);
state.bclus = zeros([1 N nrl]);
% state.vspec = zeros([1 nt nrl]);
% state.xspec = zeros([1 nt nrl]);
else
state = 0;
end

tt = 0; step = 0; 
for r = 1:nr
    
% memory flip
if r > 1
if ~fp
[list,~,~] = get_bclus(get_ww(X),1); 
else
[list,~,~] = get_bclus(wp_to_w(X,check,0),1); 
end
if list
v(list) = -v(list);
end
end

t = 0; 
% tlist = 0; vt = v(1); xt = X(1);
while t < t0

% gradient
[E,C,G] = get_L(v,X,W,fp,check,alpha,beta,fRBM);
[Ebest,flag] = breakout(E,Ebest,Esol,record);
dt = bound( 1/max(abs(G(:))) , dtlist);

% update
v = min(max( v+dt*G ,-1),1);
if ~fRBM
if ~fp
X = min(max( X+dt*(gamma*C-Y) ,0.01),1);
Y = min(max( Y+dt*(delta*X-zeta), 1),10);
else
X = min(max( X+dt*(gamma*C-Y) ,0.01*check),check);
Y = min(max( Y+dt*(delta*sum(X,d+1)-zeta), check),dd*check);
end
else
X = min(max( X+dt*(gamma*C-Y) ,0.01),1);
Y = min(max( Y+dt*(delta*X-zeta), 1),10);
end

% record
if record
if (floor(t+dt)>floor(t)) && ismember(floor(tt+dt),ttlist) 
rrec = find(ttlist == floor(tt+dt),1,'first');
state.Et(rrec) = (Esol-E)/N;
end
if ismember(r,rlist)
rec = find(rlist == r,1,'first');
% tlist = [tlist t]; vt = [vt v(1)]; xt = [xt X(1)];
if floor(t+dt) > floor(t)
if ~fp
[~,b,bg] = get_bclus(get_ww(X),0);
else
[~,b,bg] = get_bclus(wp_to_w(X,check,0),0);   
end
if sum(b)
state.bclus(1,bg,rec) = state.bclus(1,bg,rec) + b;
end
end
% if t >= t0
% state.vspec(:,:,rec) = spec(vt,tlist,nt,dt0);
% state.xspec(:,:,rec) = spec(xt,tlist,nt,dt0);
% end
end
end
t = t+dt; tt = (r-1)*t0+t; step = step+1;

% print
if ~quiet mydot(t,t0,dt,1); end
if flag break; end
end
if ~quiet
    fprintf(strcat( '\n','t = ',num2str(floor(tt)),',  dE = ',num2str(Esol-Ebest),'\n' ));
end
if flag break; end
end
conf = {v,X,Y};
end
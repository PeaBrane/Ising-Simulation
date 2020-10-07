function [Ebest,t,conf,state] = PT(betapara,nr,Esol,W,T,tw,fRBM,conf,monitor)

% load
if ~fRBM
sz = size(W); sz = sz(1:end-1); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); N = n+m;
end
betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
Ebest = 0;

% initialization
if isempty(conf)
if ~fRBM
vlist = -1+2*round(rand([sz nr]));
else
vlist = -1+2*round(rand([nr N]));
end
rlist = 1:nr;
else
vlist = conf{1};
rlist = conf{1};
end
Elist = zeros(1,nr);
if ~fRBM
field = zeros([sz nr]);
else
field = zeros([nr N]);
end
for r = 1:nr
if ~fRBM
[~,field(:,:,:,r),~,Elist(r),~] = get_E(vlist(:,:,:,r),W,false);
else
[~,field(r,:),~,Elist(r),~] = get_E(vlist(r,:),W,true);    
end
end

% monitor
quiet = monitor(1); record = monitor(2);
if record
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
state = struct;
state.E = zeros(1,bl);
state.lap = zeros(1,recs,bl);
else
state = 0; 
end

rec = 0;
for t = 1:T
    
    % sweep
    for r = 1:nr
    ir = rlist(r);
    if ~fRBM
    [vlist(:,:,:,r),field(:,:,:,r),Elist(r)] = sweep(vlist(:,:,:,r),W,field(:,:,:,r),Elist(r),betalist(ir),false);
    else
    [vlist(r,:),field(r,:),Elist(r)] = sweep(vlist(r,:),W,field(r,:),Elist(r),betalist(ir),true); 
    end
    end
    
    % PT
    ir1 = ceil(rand()*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist == ir1); r2 = find(rlist == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(r1); E2 = Elist(r2);
    prob = exp((beta1-beta2)*(E2-E1));
    if floor(rand() + prob) > 1
        rlist([r1 r2]) = rlist([r2 r1]);
    end
    
    % recording
    if record
    if t == tw
        v0 = vlist;
    end
    if t > tw
    state.E(1,rlist) = state.E(1,rlist) + (Esol-Elist)/Esol/N;
    if ismember(t-tw,tlist)
    rec = rec+1;
    if ~fRBM
    state.lap(1,rec,rlist) = reshape(sum(v0.*vlist,[1 2 3]),[1 1 bl])/N;
    else
    for r = 1:nr
    state.lap(1,rec,rlist(r)) = sum((v0(r,1:n).'*v0(r,n+1:end)).*(vlist(r,1:n).'*vlist(r,n+1:end)),'all')/(n*m);
    end
    end
    end
    end
    end
    
    % terminate
    E = max(Elist);
    if E > Ebest
        Ebest = E;
        if (Ebest>=Esol) && ~record 
            break;
        end
    end
    
    % display
    if ~quiet
        mydot(t,T,1,1);
    end    
end
if record
state.E = state.E/(T-tw);
end
conf{1} = vlist; conf{2} = rlist;
end
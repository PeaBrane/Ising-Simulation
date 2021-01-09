function [Ebest,t,conf,state] = PTI(vars,Esol,W,fRBM,T,tw,conf,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); d = length(sz); N = prod(sz);
else
sz = size(W); n = sz(1); m = sz(2); d = Inf; N = n+m;
end
betalist = geoseries(betapara(1),betapara(2),nr);
Ebest = 0;

if ~isempty(conf)
    vlist = conf{1}; rlist = conf{2};
else
    if ~fRBM
        vlist = repmat({double(-1+2*round(rand(sz,'single')))},[2 nr]);
    else
        vlist = repmat({double(-1+2*round(rand([1 N],'single')))},[2 nr]);
    end
    rlist = [1:nr; 1:nr];
end
field = cell(2,nr); Elist = zeros(2,nr);
for c = 1:2
for r = 1:nr
    [~,field{c,r},~,Elist(c,r),~] = get_E(vlist{c,r},W,fRBM);
end
end

% monitor
if record
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
state = struct;
state.E = zeros(1,2,nr);
state.dlap = zeros(1,recs,2,nr);
state.sclus = zeros(1,N,nr);
else
state = 0; 
end

rec = 0;
for t = 1:T
    
    % sweep
    for c = 1:2
    for r = 1:nr
    ir = rlist(c,r);
    [vlist{c,r},field{c,r},Elist(c,r)] = sweep(vlist{c,r},W,field{c,r},Elist(c,r),betalist(ir),fRBM);
    end
    end
    
    % ICM
    if t > tw
    for ir = 1:nr
    r1 = find(rlist(1,:) == ir); r2 = find(rlist(2,:) == ir);
    [vlist{1,r1},vlist{2,r2},b,bg] = houd(vlist{1,r1},vlist{2,r2},W,fRBM,record);
    [~,field{1,r1},~,Elist(1,r1),~] = get_E(vlist{1,r1},W,fRBM);
    [~,field{2,r2},~,Elist(2,r2),~] = get_E(vlist{2,r2},W,fRBM);
    if sum(b)
    state.sclus(1,bg,ir) = state.sclus(1,bg,ir)+b;
    end
    end
    end
    
    % PT
    for c = 1:2
    ir1 = ceil(rand('single')*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist(c,:) == ir1); r2 = find(rlist(c,:) == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(c,r1); E2 = Elist(c,r2);
    prob = exp((beta1-beta2)*(E2-E1));
    if floor(rand('single') + prob) > 1
        rlist(c,[r1 r2]) = rlist(c,[r2 r1]);
    end
    end
    
    % recording
    if record
    if t == tw
        v0 = vlist;
    end
    if t > tw
    for c = 1:2
    state.E(1,c,rlist(c,:)) = state.E(1,c,rlist(c,:)) + reshape((Esol-Elist(c,:)),[1 1 nr])/N;
    end
    if ismember(t-tw,tlist)
    rec = rec+1;
    for c = 1:2
    for r = 1:nr
    state.dlap(1,rec,c,rlist(c,:)) = sum(v0{c,r}.*vlist{c,r},'all')/N;
    end
    end
    end
    end
    end
    
    % terminate
    E = max(Elist,[],'all');
    if E > Ebest
        Ebest = E;
        if abs(Esol-Ebest)<0.01 && ~record
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
t = t*2*nr;
conf{1} = vlist; conf{2} = rlist;
end
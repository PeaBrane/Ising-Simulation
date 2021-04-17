function [Ebest,t,conf,state] = PTI(vars,falgo,Esol,W,fRBM,T,tw,conf,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
icm = falgo(2);

if ~fRBM
sz = size(W); sz = sz(1:end-1); N = prod(sz);
n = round(sz(1)/4); W = int16(W);
else
sz = size(W); N = sum(sz);
sz = [1 N]; n = round(N/4);
end
betalist = geoseries(betapara(1),betapara(2),nr);
Ebest = 0; Esol = int16(Esol);

if ~isempty(conf)
    vlist = conf{1}; rlist = conf{2};
else
    vlist = cell(2,nr);
    for c = 1:2
    for r = 1:nr
    vlist{c,r} = int16(-1+2*round(rand(sz,'single')));
%     vlist{c,r} = double(-1+2*round(rand(sz,'single')));
    end
    end
    rlist = [1:nr; 1:nr];
end
field = cell(2,nr); Elist = zeros([2 nr],'int16');
for c = 1:2
for r = 1:nr
    [~,field{c,r},~,Elist(c,r),~] = get_E(vlist{c,r},W,fRBM);
end
end

% monitor
E = zeros([1 2 nr]);
cor = zeros([1 n nr]);
con = zeros(1,n,nr);
Etot = zeros(1,2,nr);
cortot = zeros(1,n,nr);
contot = zeros(1,n,nr);

if record
state = struct;
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
ttlist = unique(round(geoseries(1,(T),10*round(log2(T))))); rrecs = length(ttlist);
v0 = vlist;

state.E = zeros(1,2,nr);
state.cor = zeros(1,n,nr);
state.con = zeros(1,n,nr);
state.Et = zeros(1,2,nr,rrecs);
state.Eb = zeros(1,rrecs);
state.cort = zeros(1,n,nr,rrecs);
state.cont = zeros(1,n,nr,rrecs);
state.dlap = zeros(1,2,nr,recs);

q = zeros(1,nr);
state.qdist = zeros(1,2*N+1,nr);
state.q2 = zeros(1,nr);
state.q4 = zeros(1,nr);
state.sclus = zeros(1,N,nr);
else
tw = 0; 
end

rec = 0; rrec = 0;
for t = 1:T
    
    % sweep
    cor = zeros(1,n,nr);
    for r = 1:nr
    for c = 1:2
    ir = rlist(c,r);
    [vlist{c,r},field{c,r},Elist(c,r)] = sweep(vlist{c,r},W,field{c,r},Elist(c,r),betalist(ir),fRBM);
    E(1,c,ir) = double(Esol-Elist(c,r))/N;
    cor(:,:,ir) = cor(:,:,ir) + double(reshape(vlist{c,r}(1)*vlist{c,r}(1:n),[1 n]));
    end
    cor(:,:,ir) = cor(:,:,ir)/2;
    end
    Etot = Etot + E;
    cortot = cortot + cor;
    [Ebest,flag1] = breakout(max(Elist(:)),Ebest,Esol,record);
    
    % ICM
    for ir = 1:nr
    r1 = find(rlist(1,:) == ir); r2 = find(rlist(2,:) == ir);
    if t > tw && icm == 1
    [vlist{1,r1},vlist{2,r2},q(ir),con(1,:,ir),b,bg] = houd(vlist{1,r1},vlist{2,r2},W,fRBM);
    [~,field{1,r1},~,Elist(1,r1),~] = get_E(vlist{1,r1},W,fRBM);
    [~,field{2,r2},~,Elist(2,r2),~] = get_E(vlist{2,r2},W,fRBM);
    else
    q(ir) = sum(vlist{1,r1}.*vlist{2,r2},'all')/N;
    b = 0; bg = [];
    con(1,:,ir) = 0;
    end
    qq = round(q(ir)*N+N+1);
    if record
    state.qdist(1,qq,ir) = state.qdist(1,qq,ir)+1;
    state.sclus(1,bg,ir) = state.sclus(1,bg,ir)+b;
    end
    end
    contot = contot + con;
    [Ebest,flag2] = breakout(max(Elist(:)),Ebest,Esol,record);
    flag = flag1 || flag2;
    
    % PT
    for c = 1:2
    ir1 = ceil(rand('single')*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist(c,:) == ir1); r2 = find(rlist(c,:) == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(c,r1); E2 = Elist(c,r2);
    prob = exp((beta1-beta2)*double(E2-E1));
    if floor(rand('single') + prob) > 1
        rlist(c,[r1 r2]) = rlist(c,[r2 r1]);
    end
    end
    
    % recording
    if record 
        
    if ismember(t,ttlist)
    rrec = rrec+1;
    state.Eb(rrec) = -double(Ebest)/N;
    state.Et(:,:,:,rrec) = Etot/t;
    state.cort(:,:,:,rrec) = cortot/t;
    state.cont(:,:,:,rrec) = contot/t;
    end
        
    if t == tw
        v0(1,rlist(1,:)) = vlist(1,:);
        v0(2,rlist(2,:)) = vlist(2,:);
    end
    
    if t > tw
    state.E = state.E + E;
    state.cor = state.cor + cor;
    state.con = state.con + con;
    state.q2 = state.q2 + q.^2;
    state.q4 = state.q4 + q.^4;
    end
    
    if ismember(t-tw,tlist)
    rec = rec+1;
    state.dlap(1,:,:,rec) = reshape(get_dlap(v0,vlist,rlist,falgo),[1 2 nr 1]);
    end
    end
    
    % terminate
    if flag
        break;
    end
    
    % display
    if ~quiet
        mydot(t,T,1,1);
    end
end
if record
state.E = state.E/(T-tw);
state.cor = state.cor/(T-tw);
state.con = state.con/(T-tw);
state.q2 = state.q2/(T-tw);
state.q4 = state.q4/(T-tw);
end
t = t*2*nr;
conf{1} = vlist; conf{2} = rlist;
end
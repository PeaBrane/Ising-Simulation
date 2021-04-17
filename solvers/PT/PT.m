function [Ebest,t,conf,state] = PT(vars,falgo,Esol,W,fRBM,T,tw,conf,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
W = int16(W);
if ~fRBM
sz = size(W); sz = sz(1:end-1); d = length(sz); N = prod(sz);
n = round(sz(1)/4);
else
sz = size(W); d = Inf; N = sum(sz); sz = [1 N]; n = round(N/4);
end
betalist = geoseries(betapara(1),betapara(2),nr);
Ebest = 0;

% initialization
if ~isempty(conf)
    vlist = conf{1}; rlist = conf{2};
else
    vlist = cell(1,nr);
    for r = 1:nr
    vlist{r} = int16(-1+2*round(rand(sz,'single')));
    end
    rlist = 1:nr;
end
field = cell(1,nr); Elist = zeros([1 nr],'int16');
for r = 1:nr
    [~,field{r},~,Elist(r),~] = get_E(vlist{r},W,fRBM);
end

% monitor
fwolff = falgo(3); fkbd = falgo(4);
if record
state = struct;
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
ttlist = unique(round(geoseries(1,(T),10*round(log2(T))))); rrecs = length(ttlist);
v0 = vlist;

E = zeros([1 nr]);
cor = zeros([1 n nr]);
con = zeros([1 n nr]);
Etot = zeros([1 nr]);
cortot = zeros([1 n nr]);
contot = zeros([1 n nr]);

state.E = zeros([1 nr]);
state.cor = zeros([1 n nr]);
state.con = zeros([1 n nr]);
state.Et = zeros([1 nr rrecs]);
state.Eb = zeros([1 rrecs]);
state.cort = zeros([1 n nr rrecs]);
state.cont = zeros([1 n nr rrecs]);
state.dlap = zeros([1 nr recs]);

state.bclus = zeros([1 N nr]);
end

g = falgo(4);
if d == 2
check = checkerboard(sz,0);
end

rec = 0; rrec = 0;
for t = 1:T
    
    % sweep
    for r = 1:nr
    ir = rlist(r);
    [vlist{r},field{r},Elist(r)] = sweep(vlist{r},W,field{r},Elist(r),betalist(ir),fRBM);
    cor(:,:,ir) = cor(:,:,ir) + double(reshape(vlist{r}(1)*vlist{r}(1:n),[1 n]));
    end
    E(rlist) = (Esol-double(Elist))/N; Etot = Etot + E;
    cortot = cortot + cor;
    [Ebest,flag1] = breakout(max(Elist),Ebest,Esol,record);
    
    % cluster
    for r = 1:nr
    ir = rlist(r);
    if t>tw
    if fwolff
    [list,b,bg,cn] = wolff(vlist{r},W,betalist(ir),0);
    elseif fkbd && (d == 2)
    [list,b,bg,cn] = kbd(vlist{r},W,betalist(ir),g,check);
    end
    
    if fwolff || fkbd
    vlist{r}(list) = -vlist{r}(list);
    [~,field{r},~,Elist(r),~] = get_E(vlist{r},W,fRBM);
    state.bclus(1,bg,ir) = state.bclus(1,bg,ir)+b; 
    con(:,:,ir) = con(:,:,ir) + cn(1:n);
    end
    end
    end
    contot = contot + con;
    [Ebest,flag2] = breakout(max(Elist),Ebest,Esol,record);
    flag = flag1 || flag2;
    
    % PT
%     if t <= tw
    ir1 = ceil(rand('single')*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist == ir1); r2 = find(rlist == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(r1); E2 = Elist(r2);
    prob = exp((beta1-beta2)*double(E2-E1));
    if floor(rand('single') + prob) > 1
        rlist([r1 r2]) = rlist([r2 r1]);
    end
%     end
    
    % recording
    if record   
    if t == tw
        v0(rlist) = vlist;
    end
    
    if ismember(t,ttlist)
    rrec = rrec+1;
    state.Eb(rrec) = -double(Ebest)/N;
    state.Et(:,:,rrec) = Etot/t;
    state.cort(:,:,:,rrec) = cortot/t;
    state.cont(:,:,:,rrec) = contot/t;
    end
    
    if t > tw
    state.E = state.E + E;
    state.cor = state.cor + cor;
    state.con = state.con + con;
    if ismember(t-tw,tlist)
    rec = rec+1;  
    state.dlap(1,:,rec) = get_dlap(v0,vlist,rlist,falgo);
    end
    end
    end
    
    % display
    if ~quiet
        mydot(t,T,1,1);
    end   
    if flag 
        break; 
    end
end

if record
state.E = state.E/(T-tw);
state.cor = state.cor/(T-tw);
state.con = state.con/(T-tw);
end

t = t*nr;
conf{1} = vlist; conf{2} = rlist;
end
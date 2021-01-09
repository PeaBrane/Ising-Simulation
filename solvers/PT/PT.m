function [Ebest,t,conf,state] = PT(vars,falgo,Esol,W,fRBM,T,tw,conf,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); d = length(sz); N = prod(sz);
else
sz = size(W); d = Inf; N = sum(sz);
end
betalist = geoseries(betapara(1),betapara(2),nr);
Ebest = 0;

% initialization
if ~isempty(conf)
    vlist = conf{1}; rlist = conf{2};
else
    if ~fRBM
        vlist = repmat({double(-1+2*round(rand(sz,'single')))},[1 nr]);
    else
        vlist = repmat({double(-1+2*round(rand([1 N],'single')))},[1 nr]);
    end
    rlist = 1:nr;
end
field = cell(1,nr); Elist = zeros(1,nr);
for r = 1:nr
    [~,field{r},~,Elist(r),~] = get_E(vlist{r},W,fRBM);
end

% monitor
fwolff = falgo(3); fkbd = falgo(4);
state = struct;
if record
state.E = zeros(1,nr);
state.smag = zeros(1,nr);
state.pmag = zeros(1,nr);

tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
state.dlap = zeros(1,recs,nr);

smagg = repmat({zeros(sz)},[1 nr]);
pmagg = repmat({zeros(sz(1)/2,sz(2))},[1 nr]);
state.slap = repmat({zeros(sz)},[1 nr]);
state.plap = repmat({zeros(sz(1)/2,sz(2))},[1 nr]);
end
state.sclus = zeros(1,N,nr);
state.bclus = zeros(1,N,nr);

g = falgo(4);
if d == 2
check = checkerboard(sz,0);
end

rec = 0;
for t = 1:T
    
    % sweep
    for r = 1:nr
    ir = rlist(r);
    [vlist{r},field{r},Elist(r)] = sweep(vlist{r},W,field{r},Elist(r),betalist(ir),fRBM);
    
    if t>tw
    if fwolff
    [list,b,bg] = wolff(vlist{r},W,betalist(ir),0);
    elseif fkbd && d == 2
    [list,b,bg] = kbd(vlist{r},W,betalist(ir),g,check);
    end
    if fwolff || fkbd
    if ~record
    vlist{r}(list.') = -vlist{r}(list.');
    [~,field{r},~,Elist(r),~] = get_E(vlist{r},W,fRBM);
    end
    if sum(b)
    state.bclus(1,bg,ir) = state.bclus(1,bg,ir)+b; 
    end
    end
    end
    
    end
    
    % PT
    ir1 = ceil(rand('single')*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist == ir1); r2 = find(rlist == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(r1); E2 = Elist(r2);
    prob = exp((beta1-beta2)*(E2-E1));
    if floor(rand('single') + prob) > 1
        rlist([r1 r2]) = rlist([r2 r1]);
    end
    
    % recording
    if record
    if t == tw
        v0 = vlist;
    end
    if t > tw
    state.E(1,rlist) = state.E(1,rlist) + (Esol-Elist)/N;
    for r = 1:nr
    ir = rlist(r);
    v = vlist{r}; 
    smagg{rlist(r)} = smagg{rlist(r)} + v;
    state.slap{rlist(r)} = state.slap{rlist(r)} + v*v(1);
    if d == 2
    s = plaq(v,W,check);
    pmagg{rlist(r)} = pmagg{rlist(r)} + s;
    state.plap{rlist(r)} = state.plap{rlist(r)} + s*s(1);
    [~,b,bg] = get_sclus(s == 1);
    state.sclus(1,bg,ir) = state.sclus(1,bg,ir)+b;
    end
    end    
    if ismember(t-tw,tlist)
    rec = rec+1;
    for r = 1:nr
    if ~fRBM
    state.dlap(1,rec,rlist(r)) = sum(v0{r}.*vlist{r},'all')/N;
    else
    state.dlap(1,rec,rlist(r)) = sum((v0{r}(1:n).'*v0{r}(n+1:end)).*(vlist{r}(1:n).'*vlist{r}(n+1:end)),'all')/(n*m);
    end
    end
    end
    end
    end
    
    % terminate
    E = max(Elist);
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
for r = 1:nr
smag = smagg{r}/(T-tw);
state.slap{r} = abs(state.slap{r}/(T-tw) - smag*smag(1,1,1));
state.smag(r) = sum(abs(smag),'all')/N;

if d == 2
pmag = pmagg{r}/(T-tw);
state.plap{r} = state.plap{r}/(T-tw) - pmag*pmag(1,1,1);
state.pmag(r) = sum(pmag,'all')/N*2;
end
end
end
t = t*nr;
conf{1} = vlist; conf{2} = rlist;
end
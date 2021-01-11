function [Ebest,t,conf,state] = PT(vars,falgo,Esol,W,fRBM,T,tw,conf,monitor)

% load
betapara = vars(1:2); nr = vars(3);
quiet = monitor(1); record = monitor(2);
if ~fRBM
sz = size(W); sz = sz(1:end-1); d = length(sz); N = prod(sz);
else
sz = size(W); d = Inf; N = sum(sz); n = sz(1); m = sz(2);
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

tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
state.tlist = tlist;

if record
state.E = zeros(1,nr);
state.dlap = zeros(1,recs,nr);
state.sclus = zeros(1,N,nr);
state.bclus = zeros(1,N,nr);
state.pmag = zeros(1,nr);
end

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
    vlist{r}(list) = -vlist{r}(list);
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
        v0 = vlist(rlist);
    end
    
    if t > tw
    state.E(1,rlist) = state.E(1,rlist) + (Esol-Elist)/N;
    for r = 1:nr
    ir = rlist(r); beta = betalist(ir); v = vlist{r}; 
    if d == 2 && ~falgo(3) && ~falgo(4)
    s = plaq(v,W,check);
    state.pmag(ir) = state.pmag(ir) + mean(s,'all');
    ss = (s==1) & logical(floor(rand(size(s),'single')+1-exp(-4*beta)));
    [~,b,bg] = get_sclus(ss);
    state.sclus(1,bg,ir) = state.sclus(1,bg,ir)+b;
    end
    end
    
    if ismember(t-tw,tlist)
    rec = rec+1;  
    for r = 1:nr
    ir = rlist(r);
    if ~fRBM
    state.dlap(1,rec,ir) = sum(v0{ir}.*vlist{r},'all')/N;
    else
    vv0 = v0{ir}(1:n); hh0 = v0{ir}(n+1:n+m);
    vv = vlist{r}(1:n); hh = vlist{r}(n+1:n+m);
    state.dlap(1,rec,ir) = sum( (vv0.*vv).'*(hh0.*hh), 'all' )/n/m; 
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
state.pmag = state.pmag/(T-tw);
end

t = t*nr;
conf{1} = vlist; conf{2} = rlist;
end
function [Ebest,t,vlist,rlist,state] = PT(betapara,nr,Esol,W,T,tw,vlist,rlist,monitor)

% load
sz = size(W); sz = sz(1:end-1); N = prod(sz);
betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
Ebest = 0;

% initialization
if (isempty(vlist) && isempty(rlist)) || (~any(vlist,'all') && ~any(rlist,'all'))
rlist = 1:nr;
vlist = -1+2*round(rand([sz nr]));
end
Elist = zeros(1,nr);
field = zeros([sz nr]);
for r = 1:nr
[~,field(:,:,:,r),~,Elist(r),~] = get_E(vlist(:,:,:,r),W,W,false);
end

% monitor
quiet = monitor(1); record = monitor(2);
state = struct;
state.E = zeros(1,T-tw,bl);
state.lap = zeros(1,T-tw,bl);

for t = 1:T
    
    % sweep
    for r = 1:nr
    ir = rlist(r);
    [vlist(:,:,:,r), field(:,:,:,r), Elist(r)] = sweep_lattice(vlist(:,:,:,r), W, field(:,:,:,r), Elist(r), betalist(ir));
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
    if t == tw
        v0 = vlist;
    end
    if t > tw
        state.E(1,t-tw,rlist) = reshape((Esol-Elist)/Esol,[1 1 bl])/N;
        state.lap(1,t-tw,rlist) = reshape(sum(v0.*vlist,[1 2 3]),[1 1 bl])/N;
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
end
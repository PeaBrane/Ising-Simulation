function [Ebest,t,vlist,rlist,state] = PTI(betapara,nr,Esol,W,T,tw,vlist,rlist,monitor)

sz = size(W); sz = sz(1:end-1); N = prod(sz);
betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
betahigh = betalist(find(betalist > 1,1,'first'):end); bhl = length(betahigh);
Ebest = 0;

% initialization
if (isempty(vlist) && isempty(rlist)) || (~any(vlist,'all') && ~any(rlist,'all'))
rlist = [1:nr; 1:nr];
vlist = -1+2*round(rand([sz 2 nr]));
end
Elist = zeros(2,nr);
field = zeros([sz 2 nr]);
for c = 1:2
for r = 1:nr
[~,field(:,:,:,c,r),~,Elist(c,r),~] = get_E(vlist(:,:,:,c,r),W,W,false);
end
end

quiet = monitor(1); record = monitor(2);
state = struct;
state.E = zeros(1,T-tw,2,bl);
state.lap = zeros(1,T-tw,2,bl);
state.clus = zeros([1 N bhl]);

for t = 1:T
    
    % sweep
    for c = 1:2
    for r = 1:nr
    ir = rlist(c,r);
    [vlist(:,:,:,c,r), field(:,:,:,c,r), Elist(c,r)] = sweep_lattice(vlist(:,:,:,c,r), W, field(:,:,:,c,r), Elist(c,r), betalist(ir));
    end
    end
    
    % ICM
    for bhi = 1:bhl
    beta = betahigh(bhi);
    r1 = find(betalist(rlist(1,:)) == beta); r2 = find(betalist(rlist(2,:)) == beta);
    [vlist(:,:,:,1,r1),vlist(:,:,:,2,r2),b,bg] = houd(vlist(:,:,:,1,r1),vlist(:,:,:,2,r2));
    [~,field(:,:,:,1,r1),~,Elist(1,r1),~] = get_E(vlist(:,:,:,1,r1),W,W,false);
    [~,field(:,:,:,2,r2),~,Elist(2,r2),~] = get_E(vlist(:,:,:,2,r2),W,W,false);
    if sum(b) && (t>tw)
    state.clus(1,bg,bhi) = state.clus(1,bg,bhi) + b;
    end
    end
    
    % PT
    for c = 1:2
    ir1 = ceil(rand()*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist(c,:) == ir1); r2 = find(rlist(c,:) == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(c,r1); E2 = Elist(c,r2);
    prob = exp((beta1-beta2)*(E2-E1));
    if floor(rand() + prob) > 1
        rlist(c,[r1 r2]) = rlist(c,[r2 r1]);
    end
    end
    
    % recording
    if t == tw
        v0 = vlist;
    end
    if t > tw
    for c = 1:2
        state.lap(1,t-tw,c,rlist(c,:)) = reshape(sum(v0(:,:,:,c,:).*vlist(:,:,:,c,:),[1 2 3]),[1 1 1 bl])/N;
        state.E(1,t-tw,c,rlist(c,:)) = reshape((Esol-Elist(c,:))/Esol,[1 1 1 bl])/N;
    end
    end
    
    % terminate
    E = max(Elist,[],'all');
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
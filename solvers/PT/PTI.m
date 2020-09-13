function [Ebest,t,vlist,rlist] = PTI(betapara,nr,Esol,W,T,quiet,vlist,rlist)

sz = size(W); sz = sz(1:end-1);

Ebest = 0;
if nr <= 1
    t = Inf;
    return;
else
    nr = ceil(nr);
end

betalist = geoseries(betapara(1),betapara(2),nr);
betahigh = betalist(find(betalist > 1,1,'first'):end);

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

for t = 1:T
    
    % monte carlo sweep
    for c = 1:2
    for r = 1:nr
    ir = rlist(c,r);
    [vlist(:,:,:,c,r), field(:,:,:,c,r), Elist(c,r)] = sweep_lattice(vlist(:,:,:,c,r), W, field(:,:,:,c,r), Elist(c,r), betalist(ir));
    end
    end
    
    %Houdayer
    for beta = betahigh
    r1 = find(betalist(rlist(1,:)) == beta); r2 = find(betalist(rlist(2,:)) == beta);
    [vlist(:,:,:,1,r1),vlist(:,:,:,2,r2)] = houd(vlist(:,:,:,1,r1),vlist(:,:,:,2,r2));
    [~,field(:,:,:,1,r1),~,Elist(1,r1),~] = get_E(vlist(:,:,:,1,r1),W,W,false);
    [~,field(:,:,:,2,r2),~,Elist(2,r2),~] = get_E(vlist(:,:,:,2,r2),W,W,false);
    end
    
    % parallel tempering
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
    
    E = max(Elist,[],'all');
    if E > Ebest
        Ebest = E;
        if Ebest >= Esol
            break;
        end
    end
    
    if ~quiet
        mydot(t,T,1,1);
    end

end

end
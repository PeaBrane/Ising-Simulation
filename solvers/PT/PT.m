function [Ebest, t] = PT(betapara,nr,Esol,W,T,quiet)

sz = size(W); sz = sz(1:end-1);

betalist = geoseries(betapara(1),betapara(2),nr);

Ebest = 0;

% initialization
rlist = 1:nr;
vlist = -1+2*round(rand([sz nr]));
Elist = zeros(1,nr);
field = zeros([sz nr]);
for r = 1:nr
[~,field(:,:,:,r),~,Elist(r),~] = get_E(vlist(:,:,:,r),W,W,false);
end

for t = 1:T
    
    % monte carlo sweep
    for r = 1:nr
    ir = rlist(r);
    [vlist(:,:,:,r), field(:,:,:,r), Elist(r)] = sweep_lattice(vlist(:,:,:,r), W, field(:,:,:,r), Elist(r), betalist(ir));
    end
    
    % parallel tempering
    ir1 = ceil(rand()*(nr-1)); ir2 = ir1+1;
    r1 = find(rlist == ir1); r2 = find(rlist == ir2);
    beta1 = betalist(ir1); beta2 = betalist(ir2);
    E1 = Elist(r1); E2 = Elist(r2);
    prob = exp((beta1-beta2)*(E2-E1));
    if floor(rand() + prob) > 1
        rlist([r1 r2]) = rlist([r2 r1]);
    end
    
    E = max(Elist);
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
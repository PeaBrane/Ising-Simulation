function [v,E_best] = PT_iso(E_sol,W,beta_list,T,t)

flag = 0;
runs = ceil(T/t);

n = size(W,1); m = size(W,2); k = size(W,3);
nr = length(beta_list);

vlist = zeros(n,m,k,nr,2);
Elist = zeros(nr,2);
ilist = [1:nr; 1:nr].';

for run = 1:runs

for r = 1:nr
for c = 1:2
v = rand_spins_3d(n,m,k);
vlist(:,:,:,r,c) = rand_spins_3d(n,m,k);
Elist(r,c) = get_E(v,W); 
end
end
E_best = max(Elist(:));

for iter = 1:t
    
    % monte carlo sweep
    for r = 1:nr
    for c = 1:2
    ir = ilist(r,c);
    [vlist(:,:,:,ir,c), Elist(ir,c)] = msweep(vlist(:,:,:,ir,c), W, beta_list(r), Elist(ir,c));
    end
    end
    
    % Houdayer
    for r = 1:nr
    if beta_list(r) < 1
        continue;
    end
    ir1 = ilist(r,1); ir2 = ilist(r,2);
    v1 = vlist(:,:,:,ir1,1); v2 = vlist(:,:,:,ir2,2);
    [v1,v2] = houd(v1,v2);
    vlist(:,:,:,ir1,1) = v1; vlist(:,:,:,ir2,2) = v2;
    Elist(ir1,1) = get_E(v1,W); Elist(ir2,2) = get_E(v2,W);
    end

    % parallel tempering
    r = ceil(rand()*(nr-1));
    ir11 = ilist(r,1); ir12 = ilist(r+1,1);
    ir21 = ilist(r,2); ir22 = ilist(r+1,2);
    E11 = Elist(ir11,1); E12 = Elist(ir12,1);
    E21 = Elist(ir21,2); E22 = Elist(ir22,2);
    beta1 = beta_list(r); beta2 = beta_list(r+1);
    prob1 = exp((beta1-beta2)*(E11-E12));
    prob2 = exp((beta1-beta2)*(E21-E22));
    if floor(rand() + prob1) > 1
        ilist([r r+1],1) = ilist([r+1 r],1);
    end
    if floor(rand() + prob2) > 1
        ilist([r r+1],2) = ilist([r+1 r],2);
    end

    if mod(iter,1000) == 0
        fprintf('.');
    end
    
    if max(Elist(:)) > E_best
        E_best = max(Elist(:));
    end
    
    if E_best == E_sol
        flag = 1;
        break;
    end
    
end

if flag
    break;
end

fprintf('\n');

end

end
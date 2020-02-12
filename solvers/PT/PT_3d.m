function [v,E_best] = PT_3d(E_sol,W,beta_list,T,t)

flag = 0;
runs = ceil(T/t);

n = size(W,1); m = size(W,2); k = size(W,3);
nr = length(beta_list);

for run = 1:runs

Elist = zeros(1,nr);
ilist = 1:nr;    
vlist = rand_v([n m k nr]);
vlist = sign(vlist);

for r = 1:nr
v = vlist(:,:,:,r);
Elist(r) = get_E(v,W); 
end
E_best = max(Elist);

for iter = 1:t
    
    % monte carlo sweep
    for r = 1:nr
    ir = ilist(r);
    [vlist(:,:,:,ir), Elist(ir)] = msweep(vlist(:,:,:,ir), W, beta_list(r), Elist(ir));
    end
    
    % parallel tempering
    r = ceil(rand()*(nr-1));
    ir1 = ilist(r); ir2 = ilist(r+1);
    E1 = Elist(ir1); E2 = Elist(ir2);
    beta1 = beta_list(r); beta2 = beta_list(r+1);
    prob = exp((beta1-beta2)*(E2-E1));
    if floor(rand() + prob) > 1
        ilist([r r+1]) = ilist([r+1 r]);
    end
    
    if mod(iter,1000) == 0
        fprintf('.');
    end
    
    if max(Elist) > E_best
        E_best = max(Elist);
        if E_best == E_sol
            flag = 1;
            breal
        end
    end
    
end

if flag
    break;
end

fprintf('\n');

end

end
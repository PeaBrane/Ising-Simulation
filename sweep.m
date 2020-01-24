function [E_best,t] = sweep(n,m,a,b,W,n_monte,beta_list,E_sol,dev)

v = rand_spins(n);
h = rand_spins(m);
E = a*v.' + b*h.' + v*W*h.'; E_best = E;
theta = v*W + b;
phi = h*W.' + a;

t = Inf;

if dev
    eng_dev = E_sol*dev;
else
    eng_dev = 0.01;
end

for monte = 1:n_monte
    
    beta_min = beta_list(1); beta_max = beta_list(2);
    beta = beta_min + (monte-1)/(n_monte-1)*(beta_max - beta_min); 
    
    ratio = exp(-2*beta*theta.*h);
    hlist = logical(floor(ratio + rand(1,m)));
    h(hlist) = -h(hlist);
    phi = (W*h.').';
    
    ratio = exp(-2*beta*phi.*v);
    vlist = logical(floor(ratio + rand(1,n)));
    v(vlist) = -v(vlist);
    theta = v*W;
    
    E = a*v.' + b*h.' + v*W*h.';
    
    if E >= E_best
        E_best = E;
        if abs(E-E_sol) <= eng_dev
            t = monte;
            break;
        end
    end
        
end
    
end
function [tot,E_best] = SA_lattice(E_sol,w,beta_list,T,t)

runs = ceil(T/t);
n = size(w,1); m = size(w,2); k = size(w,3);

bmin = beta_list(1); bmax = beta_list(2);

flag = 0;
E_best = 0;

W = get_W(w);
tot = 0;

for run = 1:runs
v = -1+2*round(rand([n m k]));
[~,field,E] = get_E(v,W);
for dt = 1:t
    
    beta = bmin + (dt-1)/(t-1)*(bmax - bmin);
    [v, field, E] = sweep_lattice(v,W,field,E,beta);
    
    if E > E_best
        E_best = E;
        if E_best == E_sol
            flag = 1;
            break;
        end
    end
    
end

fprintf('.');
if flag
    tot = tot + dt;
    break;
end

tot = tot + t;

end

end
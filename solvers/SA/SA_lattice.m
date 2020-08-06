function [Ebest, t] = SA_lattice(betapara,t0,Esol,W,T,quiet)

flag = 0;
if t0 < 1 || t0 > T
    Ebest = -Esol;
    t = T;
    return;
end

sz = size(W); sz = sz(1:end-1); N = prod(sz);
restarts = ceil(T/t0);

betalist = linspace(betapara(1),betapara(2),t0);

for restart = 1:restarts
v = -1+2*round(rand(sz));
[~,field,~,E,~] = get_E(v,W);

for dt = 1:t0
    
beta = betalist(dt);
[v, field, E] = sweep_lattice(v,W,field,E,beta);

if E > Ebest
    Ebest = E;
    if Ebest == Esol
        flag = 1;
        break;
    end
end
    
if ~quiet
mydot((restart-1)*t0+dt,restarts*t0,1,1);
end
    
end

if flag
    break;
end

end

t = (restart-1)*t0 + dt;

end
function [Ebest, t] = SA_lattice(betapara,Esol,W,T,quiet)

sz = size(W); sz = sz(1:end-1); N = prod(sz);

t = 10*N;
restarts = ceil(T/t);
sz = size(W); sz = sz(1:end-1);

betalist = linspace(betapara(1),betapara(2),t);

flag = 0;
Ebest = 0;

for restart = 1:restarts
v = -1+2*round(rand(sz));
[~,field,~,E,~] = get_E(v,W);

for dt = 1:t
    
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
mydot((restart-1)*t+dt,restarts*t,1,1);
end
    
end

if flag
    break;
end

end

t = (restart-1)*t + dt;

end
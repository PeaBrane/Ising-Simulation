function tsol = SA_time(beta,Esol,W,T,t0,dev)

n = size(W,1); m = size(W,2);
a = zeros(1,n); b = zeros(1,m);

t = Inf; tsol = 0;
while t == Inf
    [~,t] = sweep_rbm(n,m,a,b,W,t0,beta,Esol,dev);
    if t == Inf
        tsol = tsol + t0;
    else
        tsol = tsol + t;
    end
    if tsol > T
        break;
    end
end

end
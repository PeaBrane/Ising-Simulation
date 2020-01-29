function T = SA_time(n,m,a,b,w,n_monte,beta,E,t_cap,dev)

t = Inf; T = 0;
while t == Inf
    [~,t] = sweep(n,m,a,b,w,n_monte,beta,E,dev);
    if t == Inf
        T = T + n_monte;
    else
        T = T + t;
    end
    if T > t_cap
        T = t_cap;
        break;
    end
end

end
function tsol = SA_time(beta,Esol,w,T,t0,dev)

tsol = 0;
while true
    [Ebest,t] = SArbm(beta,t0,w,Esol,dev);
    tsol = tsol + t;
    if Esol == Ebest
        break;
    end
end

end
function fdot = mydot(t,t0,dt,flag)

fdot = 0;
if floor((t+dt)/t0*100) > floor(t/t0*100)
    fdot = 1;
    if flag
        fprintf('.');
    else
        fprintf('x');
    end
end

end
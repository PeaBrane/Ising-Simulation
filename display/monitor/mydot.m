function mydot(t,t0,dt,flag)

if floor(t/t0*100) > floor((t-dt)/t0*100)
    if flag
        fprintf('.');
    else
        fprintf('x');
    end
end

end
function [Ebest,flag] = breakout(E,Ebest,Esol,record)

flag = 0;
if E > Ebest
    Ebest = E;
    if abs(Esol-Ebest)<0.01 && ~record && Esol
        flag = 1;
    end
end

end
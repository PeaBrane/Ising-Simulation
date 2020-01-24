function list = betalist(n, rho)

list = [0.01 log(n)];

if rho > 1
    list = list/rho;
end

end
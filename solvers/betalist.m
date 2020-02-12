function list = betalist(n, rho, scale, flag)
% returns the appropriate inverse temperature schedule
% for an (n x n) RBM with loop density rho

list = [0.01 log(n)];

% scales down the inverse temperature
% when the loop density becomes extensive
if rho > n && flag
    list = list*(n/rho);
end

% accounts for the scale of the loop weights
list = list/scale;

end
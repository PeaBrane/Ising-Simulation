function [E_best,t] = sweep_rbm(n,m,a,b,W,n_monte,beta_list,E_sol,dev)
% performs an SA run on an (n x m) RBM
% n_monte is the number of sweeps per run
% beta_list is the inverse temperature schedule
% E_sol is the planted solution
% dev is the allowed percentage deviation from the optimum
% E_best is the best energy found over the run
% t is the total number of sweeps performed until the optimum is found
% t=Inf if the optimum is not found

t = Inf;
n_monte = floor(n_monte);
beta_min = beta_list(1); beta_max = beta_list(2);
    
v = -1 + 2*round(rand(1,n)); % initializes the visible spins randomly
h = -1 + 2*round(rand(1,m)); % initializes the hidden spins randomly
E = a*v.' + b*h.' + v*W*h.'; % gets current energy
E_best = E; % records best energy
theta = v*W + b; % evaluates theta angles

% assumes that all weights are integer
if dev
    eng_dev = E_sol*dev;
else
    eng_dev = 0.01;
end

% performs n_monte number of sweeps
for monte = 1:n_monte    
    
    % updates the inverse temperature
    beta = beta_min + (monte-1)/(n_monte-1)*(beta_max - beta_min); 
    
    % sweeps over the hidden layer and updates the phi angles
    ratio = exp(-2*beta*theta.*h);
    hlist = logical(floor(ratio + rand(1,m)));
    h(hlist) = -h(hlist);
    phi = (W*h.').';
    
    % sweeps over the visible layer and updates the theta angles
    ratio = exp(-2*beta*phi.*v);
    vlist = logical(floor(ratio + rand(1,n)));
    v(vlist) = -v(vlist);
    theta = v*W;
    
    % updates the energy
    E = a*v.' + b*h.' + v*W*h.';
    
    % records the best energy found so far and checks against the optimum
    % terminates the run if the optimum is found
    if E >= E_best
        E_best = E;
        if abs(E-E_sol) <= eng_dev
            t = monte;
            break;
        end
    end
        
end
    
end
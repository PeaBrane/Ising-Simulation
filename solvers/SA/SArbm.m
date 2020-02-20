function [Ebest,t] = SArbm(betapara,t0,W,Esol,dev)
% performs an SA run on an (n x m) RBM
% n_monte is the number of sweeps per run
% beta_list is the inverse temperature schedule
% E_sol is the planted solution
% dev is the allowed percentage deviation from the optimum
% E_best is the best energy found over the run
% t is the total number of sweeps performed until the optimum is found
% t=Inf if the optimum is not found

n = size(W,1); m = size(W,2);
betalist = linspace(betapara(1),betapara(2),t0);
    
v = -1 + 2*round(rand(1,n)); % initializes the visible spins randomly
h = -1 + 2*round(rand(1,m)); % initializes the hidden spins randomly
E = v*W*h.'; % gets current energy
Ebest = E; % records best energy
theta = v*W; % evaluates theta angles

% assumes that all weights are integer
if dev
    eng_dev = Esol*dev;
else
    eng_dev = 0.01;
end

% performs n_monte number of sweeps
for t = 1:t0
    
    % updates the inverse temperature
    beta = betalist(t);
    
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
    E = v*W*h.';
    
    % records the best energy found so far and checks against the optimum
    % terminates the run if the optimum is found
    if E >= Ebest
        Ebest = E;
        if abs(E-Esol) <= eng_dev
            break;
        end
    end
        
end
    
end
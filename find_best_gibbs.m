function [v_best,h_best,E_best] = find_best_gibbs(n,m,a,b,W,n_monte,beta_list)

v = rand_spins(n); v_best = v; % random visible spin initialization
h = rand_spins(m); h_best = h; % random hidden spin initialization
E = get_E(v,h,a,b,W); E_best = E; % initial energy
theta = v*W + b; % initial theta angle 
phi = h*W.' + a; % initial phi angle

for monte = 1:n_monte
    
    beta_min = beta_list(1); beta_max = beta_list(2);
    beta = beta_min + (monte-1)/(n_monte-1)*(beta_max - beta_min); 
    % update inverse temperature for every iteration
    
    % visible spin update
    for j = 1:m 
        h(j) = -h(j);
        ratio = exp(2*beta*theta(j)*h(j)); % find acceptance ratio
        x = rand();
        if x > ratio 
            h(j) = -h(j); % reject the update
        else
            % accept the update
            E = E + 2*theta(j)*h(j); % update the energy
            phi = phi + 2*h(j)*W(:,j).'; % update the angle
        end
    end
    
    % hidden spin update
    for i = 1:n
        v(i) = -v(i);
        ratio = exp(2*beta*phi(i)*v(i));
        x = rand();
        if x > ratio
            v(i) = -v(i);
        else
            E = E + 2*phi(i)*v(i);
            theta = theta + 2*v(i)*W(i,:);
        end
    end
    
    if E >= E_best
        E_best = E; % record best energy obtained so far
        v_best = v; % record best visible layer configuration so far
        h_best = h; % record best hidden layer configuration so far
    end
        
end
    
end
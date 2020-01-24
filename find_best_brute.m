function [spins_list, hidden_list, E_list] = find_best_brute(n,m,n_monte,a,b,W)

c = n+m;
spins_gen = gen_spins(c);

E_gen(1:2^c) = 0;
for i = 1:2^c
    spins = spins_gen(i,1:n);
    hidden = spins_gen(i,n+1:n+m);
    E_gen(i) = real(a)*spins.' + real(b)*hidden.' + spins*real(W)*hidden.';
end

[E_list, indices] = sort(E_gen, 'descend');
indices = indices(1:n_monte);
E_list = E_list(1:n_monte);
spins_list = spins_gen(indices,1:n);
hidden_list = spins_gen(indices,n+1:n+m);

end
clear;

n = 5;
a1 = 0.1;
a2 = 0.2;
scale = 100;
n_loops = 20;

[a,b,w,E] = loop_SAT(n,a1,a2,scale,n_loops);

runs = 2^(4*n);
vlist = gen_spins(2*n);
hlist = gen_spins(2*n);
E_list = zeros(1,runs);
for run = 1:runs
    [i,j] = ind2sub([2^(2*n) 2^(2*n)], run);
    v = vlist(i,:); h = hlist(j,:);
    E_list(run) = a*v.' + b*h.' + v*w*h.';
    if mod(run, 10000) == 0
        fprintf('.');
    end
end
histogram(E_list);
max(E_list)
function spins = gen_spins(n)

spins = zeros(2^n, n);
for i = 1:2^n
    for j = 1:n
        spins(i, j) = -1 + 2*floor(mod(i-1, 2^(n-j+1)) / 2^(n-j));
    end
end

end
function v = rand_spins(n)

v(1:n) = 0;
for i = 1:n
    x = rand();
    if x<0.5
        v(i) = -1;
    else
        v(i) = 1;
    end
end

end
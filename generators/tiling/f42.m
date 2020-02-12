function cube = f42()

cube = ones(1,12);
i = ceil(rand()*6);

if i <= 4
    i1 = i;
    i2 = mod4(i+2) + 4;
else
    i1 = i + 4;
    i2 = i1 + 2;
end

cube([i1 i2]) = cube([i1 i2]) - 2;

end
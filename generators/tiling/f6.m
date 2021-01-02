function cube = f6()

cube = ones(1,12);

i = ceil(rand('single')*4);
j = ceil(rand('single')*2);

if j == 1
    i1 = mod4(i+1) + 4;
    i2 = mod4(i+3) + 8;
else
    i1 = mod4(i+3) + 4;
    i2 = mod4(i+2) + 8;
end

cube([i i1 i2]) = cube([i i1 i2]) - 2;

end
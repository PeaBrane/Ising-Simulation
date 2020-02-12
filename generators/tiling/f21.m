function cube = f21()

cube = ones(1,12);
i = ceil(rand()*12);
cube(i) = cube(i) - 2;

end
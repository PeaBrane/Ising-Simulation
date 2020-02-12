function cube = f41()

cube = ones(1,12);
faces = get_faces();

fi = 2*ceil(rand()*3)-1;
i = ceil(rand()*2);

j1 = ceil(rand()*4);
j2 = mod4(j1+2*i-1);

i1 = faces(fi,j1);
i2 = faces(fi+1,j2);

cube([i1 i2]) = cube([i1 i2]) - 2;

end
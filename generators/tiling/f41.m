function cube = f41()

cube = ones(1,12);
faces = get_faces();

fi = 2*ceil(rand('single')*3)-1;
i = ceil(rand('single')*2);

j1 = ceil(rand('single')*4);
j2 = mod4(j1+2*i-1);

i1 = faces(fi,j1);
i2 = faces(fi+1,j2);

cube([i1 i2]) = cube([i1 i2]) - 2;

end
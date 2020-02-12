function cube = f22()

faces = get_faces();
cube = ones(1,12);

i = ceil(rand()*6);
j = ceil(rand()*2);

index = [faces(i,j) faces(i,j+2)];

cube(index) = cube(index) - 2;

end
function mat = randround(mat)

sz = size(mat);

mat = -ones(sz)+2*floor((mat+1)/2+rand(sz));

end
function w = loop3(scale,a)

w = zeros(3,3);

w(1,1) = a; w(2,2) = a; w(3,3) = a;
w(2,1) = -scale; w(3,2) = -scale; w(1,3) = -scale;

end
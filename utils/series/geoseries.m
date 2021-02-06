function list = geoseries(x,y,n)

r = (y/x)^(1/(n-1));
list = x*r.^(0:n-1);

end
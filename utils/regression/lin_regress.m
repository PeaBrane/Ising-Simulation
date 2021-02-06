function k = lin_regress(x,y)

m = length(x); k = zeros(0,3);
k(1:2) = polyfit(x,y,1); 
xm = mean(x); xs = sum((x-xm).^2);
yh = k(1)*x+k(2); ys = sum((y-yh).^2);
k(3) = sqrt( ys/xs/(m-2) );

end
function [x,y] = poly_line(ind,list)

p = polyfit(log(ind), log(list), 1);
x = linspace(ind(1),ind(end),1000);
y = exp(p(2))*x.^p(1);

end
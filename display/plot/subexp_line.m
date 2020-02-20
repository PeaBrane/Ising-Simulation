function [x,y] = subexp_line(ind,list)

p = polyfit(sqrt(ind), log(list), 1);
x = linspace(ind(1),ind(end),1000);
y = exp(p(2))*exp(p(1)*sqrt(x));

end
function [x,y] = exp_line(ind,list)

p = polyfit(ind, log(list), 1);
x = linspace(ind(1),ind(end),1000);
y = exp(p(2))*exp(x*p(1));

end
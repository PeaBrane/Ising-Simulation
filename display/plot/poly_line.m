function [x1,x2,y1,y2,a,b] = poly_line(indices,list,index)

a = polyfit(log(indices(1:index)), log(list(1:index)), 1);
b = polyfit(log(indices(index:end)), log(list(index:end)), 1);

x1 = linspace(indices(1),indices(index),1000);
x2 = linspace(indices(index),indices(end),1000);
y1 = exp(a(2))*x1.^a(1);
y2 = exp(b(2))*x2.^b(1);

end
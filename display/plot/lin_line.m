function [x,y,k] = lin_line(indices,list)

k = polyfit(indices,list,1);
x = linspace(indices(1),indices(end),1000);
y = k(1)*x + k(2);

end
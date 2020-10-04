function [x,y,k] = poly_line(ind,list,mm)

list = truncate(list); ind = ind(1:length(list));
k = polyfit(log(ind(mm)),log(list(mm)),1); 
x = geoseries(ind(1),ind(end),1000);
y = exp(k(2))*x.^k(1);
k = k(1);

end
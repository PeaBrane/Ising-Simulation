function [x,y,k] = poly_line(ind,list,f_fit)

f = f_fit(1); mm = f_fit(2):f_fit(3);
list = truncate(list); 
ind = ind(1:length(list));

if f < 1
k = lin_regress(ind(mm).^(f),list(mm));
x = linspace(ind(1),ind(end),1000);
y = k(1)*x.^f+k(2);
elseif f == 1
k = lin_regress(ind(mm),list(mm));
x = linspace(ind(1),ind(end),1000);
y = k(1)*x+k(2);
elseif f == 2
k = lin_regress(log(ind(mm)),log(list(mm)));
x = geoseries(ind(1),ind(end),1000);
y = exp(k(2))*x.^k(1);
elseif f >= 3
k = lin_regress(ind(mm).^(f-3), log(list(mm)));
x = geoseries(ind(1),ind(end),1000);
y = exp( k(1)*x.^(f-3) + k(2) );
end

end
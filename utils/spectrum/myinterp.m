function y = myinterp(x,t,t0)

n = length(t0);
y = zeros(1,n);

for i = 1:n
    
    ii = find(t-t0(i)>0, 1, 'first');
    y(i) = interp1([x(ii-1) x(ii)], [t(ii-1) t(ii)], t0(i));

end

end
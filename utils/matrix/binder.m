function g = binder(q2,q4)

g = 0.5*(3 - mean(q4,1)./mean(q2,1).^2);

end
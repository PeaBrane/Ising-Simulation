function [c,ceq] = uvec(V)

c = [];
ceq = sum((sum(V.^2, 1)-1).^2,2);

end
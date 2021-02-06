function [x,y] = pop_zero(x,y)

ind = find(~y); y(ind) = []; x(ind) = [];

end
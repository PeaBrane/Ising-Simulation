function c = my_intersect(a,b)

p = zeros(1, max([max(a) max(b)]));
p(a) = 1;
c = b(logical(p(b)));

end
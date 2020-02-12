function [C,field] = get_C(v,V,W,d)

if d == 2
field = W.*V;
C = 0.5 * (1 - field.*repmat(v, [1 1 4]));
elseif d == 3
field = W.*V;
C = 0.5 * (1 - field.*repmat(v, [1 1 1 6]));
end

end
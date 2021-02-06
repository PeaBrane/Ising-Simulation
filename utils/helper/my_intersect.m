function c = my_intersect(a,b)

% for ii = length(b):-1:1
% if ~any(a==b(ii))
%     b(ii) = [];
% end
% end

ma = max([max(a) max(b)]);
p = false([1 ma]);
p(a) = 1;
c = b(p(b));

end
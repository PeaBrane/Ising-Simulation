function vars = get_vars(list,iter)

dim = length(list);
sz = [];
for d = 1:dim
    sz = [sz length(list{d})];
end

if length(iter) ~= length(list)
    sub = myind2sub(sz,iter);
else
    sub = iter;
end

vars = zeros(1,dim);

for d = 1:dim
    l = list{d};
    i = sub(d);
    vars(d) = l(i);
end

end
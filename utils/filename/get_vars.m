function vars = get_vars(list,iter)

dim = length(list);
sz = [];
for d = 1:dim
    sz = [sz length(list{d})];
end

sub = myind2sub(sz,iter);
vars = zeros(1,dim);

for d = 1:dim
    l = list{d};
    i = sub(d);
    vars(d) = l(i);
end

end
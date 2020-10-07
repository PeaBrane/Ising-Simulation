function ll = cellmean(list)

sz = size(list); n = sz(1); m = sz(2); ll = cell(1,m);
for j = 1:m
temp = zeros(size(list{1,j}));
for i = 1:n
temp = temp+list{i,j};
end
ll{j} = normalize(temp,2,'norm',1);
end

end
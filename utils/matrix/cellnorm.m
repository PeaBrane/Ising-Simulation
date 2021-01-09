function ll = cellnorm(list)

n = size(list,2); ll = cell(1,n);
for i = 1:n
ll{i} = normalize(list{i},2,'norm',1);
end

end
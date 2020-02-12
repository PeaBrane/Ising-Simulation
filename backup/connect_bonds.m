function bonds = connect_bonds(labels,index_list)

n = size(labels,1); m = size(labels,2);
bonds = zeros(n,m,2);

for i = 1:n
i2 = mod(i,n)+1;
for j = 1:m
j2 = mod(j,m)+1;
    
    label = labels(i,j);
    index = find(index_list == label);
    
    if label ~= 0
    if labels(i,j2) == label
        bonds(i,j,1) = index;
    end
    if labels(i2,j) == label
        bonds(i,j,2) = index;
    end
    end

end
end

end
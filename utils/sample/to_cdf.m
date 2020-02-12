function cdf = to_cdf(list)

l = length(list);
listsum = zeros(1,l);
listsum(1) = list(1);

for i = 2:l
   listsum(i) = sum(list(1:i)); 
end

cdf = listsum/listsum(l);

end
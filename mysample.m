function ele = mysample(list)

l = length(list);

if l < 1
    ele = 0;
else
    i = ceil(l*rand());
    ele = list(i);
end

end
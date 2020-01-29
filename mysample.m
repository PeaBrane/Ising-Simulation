function ele = mysample(list)

l = length(list);

if l
    i = ceil(l*rand());
    ele = list(i);
else
    ele = 0;
end

end
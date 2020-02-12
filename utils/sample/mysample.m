function ele = mysample(list)
% a fast algorithm for sampling an element from a list
% returns 0 if the list is empty

l = length(list);

if l
    i = ceil(l*rand());
    ele = list(i);
else
    ele = 0;
end

end
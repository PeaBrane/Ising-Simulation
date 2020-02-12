function [sz,list] = collapse(list)

sz = [length(list{end})];
ll = length(list);
for i = ll-1:-1:1
    
    l = length(list{i});
    if l == 1
        list(i) = [];
    else
        sz = [l sz];
    end
    
end

end
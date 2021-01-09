function [idx,ind] = discard(idx)

m = max(idx); ind = [];
for i = 1:m
    ii = find(idx == i);
    if length(ii) == 1
        idx(ii) = 0;
    elseif ~isempty(ii)
        ind = [ind i]; 
    end
end

end
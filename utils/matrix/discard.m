function [list,ind] = discard(list)

m = max(list); ind = [];
for i = 1:m
   ii = find(list == i);
   if length(ii) == 1
       list(ii) = 0;
   else
       ind = [ind i];
   end
end

end
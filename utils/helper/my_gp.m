function [b,bg] = my_gp(list)

ll = length(list);
b = []; bg = []; 

while ll>0
   
    li = list(ll);
    ind = find(list==li);
    l = length(ind);
    
    b = [b l]; bg = [bg li];
    list(ind) = [];
    ll = ll-l;
    
end

end
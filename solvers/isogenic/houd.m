function [v1,v2] = houd(v1,v2)

n = size(v1,1);  
m = size(v1,2); 
k = size(v1,3);
N = n*m*k;

differ = v1 ~= v2;
list = cluster(differ);

if list == 0
    return;
end

if length(list) > ceil(N/2)
    if rand() < 0.5
        v1 = -v1;
    else
        v2 = -v2;
    end
    differ = v1 ~= v2;
    list = cluster(differ);
    if list == 0
        return;
    end
    
end

v1(list) = -v1(list);
v2(list) = -v2(list);

end
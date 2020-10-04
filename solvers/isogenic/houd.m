function [v1,v2,b,bg] = houd(v1,v2)

sz = size(v1);
n = sz(1); m = sz(2); k = sz(3);
N = n*m*k;

differ = v1 ~= v2;
[list,b,bg] = get_sclus(differ);

if list == 0
    return;
end

if bg(end) > ceil(N/2)
    if rand() < 0.5
        v1 = -v1;
    else
        v2 = -v2;
    end
    differ = v1 ~= v2;
    [list,b,bg] = get_sclus(differ);
    if list == 0
        return;
    end   
end

v1(list) = -v1(list);
v2(list) = -v2(list);

end
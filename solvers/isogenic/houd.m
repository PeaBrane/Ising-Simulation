function [v1,v2,b,bg] = houd(v1,v2,W,fRBM)

sz = size(W); 
if ~fRBM
N = prod(sz(1:end-1));
else
N = sum(sz); 
end

differ = v1 ~= v2;
if ~fRBM
[list,b,bg] = get_sclus(differ);
else
[list,b,bg] = get_RBMclus(differ,W); 
end

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
    if ~fRBM
    [list,b,bg] = get_sclus(differ);
    else
    [list,b,bg] = get_RBMclus(differ,W);
    end
    if list == 0
        return;
    end   
end

v1(list) = -v1(list);
v2(list) = -v2(list);

end
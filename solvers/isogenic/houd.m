function [v1,v2,b,bg] = houd(v1,v2,W,fRBM,record)

sz = size(W); 
flag = 0;
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
    if rand('single') < 0.5
        v1 = -v1; 
        flag = 1;
    else
        v2 = -v2; 
        flag = 2;
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

if ~record
v1(list) = -v1(list);
v2(list) = -v2(list);
else
if flag == 1
    v1 = -v1;
elseif flag == 2
    v2 = -v2; 
end
end

end
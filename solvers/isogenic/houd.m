function [v1,v2,q,con,b,bg] = houd(v1,v2,W,fRBM)

sz = size(W); n = round(sz(1)/4);
if ~fRBM
N = prod(sz(1:end-1));
else
N = sum(sz); 
end
con = zeros([1 N]);

differ = v1 ~= v2;
if sum(differ(:)) > ceil(N/2)
if rand('single') < 0.5
    v1 = -v1; 
else
    v2 = -v2; 
end
differ = v1 ~= v2;
end

if ~fRBM
[list,b,bg,con] = get_sclus(differ);
else
[list,b,bg] = get_RBMclus(differ,W); 
end

v1(list) = -v1(list);
v2(list) = -v2(list);
q = double(sum(v1.*v2,'all'))/N;
con = con(1:n);

end
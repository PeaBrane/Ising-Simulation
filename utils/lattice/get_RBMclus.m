function [list,b,bg] = get_RBMclus(v,W)

n = size(W,1); h = v(n+1:end); v = v(1:n);
W = (v.'*h) & W;
[list,b,bg] = get_bclus(W,false);

end
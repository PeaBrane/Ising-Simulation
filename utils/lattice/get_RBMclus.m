function [list,b,bg] = get_RBMclus(v,w)

n = size(w,1); h = v(n+1:end); v = v(1:n);
w = (v.'*h) & w;
[list,b,bg] = get_bclus(w,false);

end
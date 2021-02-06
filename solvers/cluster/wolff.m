function [list,b,bg,cn] = wolff(v,W,beta,gamma)

v = double(v); W = double(W);
w = get_ww(W); sz = size(w);
w = get_frus(v,w);
w = (logical(floor( 1-exp(-2*beta*w-gamma) + rand(sz,'single') )) & (w>0)) ...
  + (logical(floor( 1-exp(-gamma) + rand(sz,'single') )) & (w<0));
[list,b,bg,cn] = get_bclus(w,false);

end
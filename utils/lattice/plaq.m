function [vp,w] = plaq(v,W,check)

w = get_ww(W); shade = ~check(1,1);
w = get_frus(v,w); wp = wp_to_w(w,check,1); vp = sum(wp,3)==2;
vp = -1+2*dual(vp,shade,1);

end
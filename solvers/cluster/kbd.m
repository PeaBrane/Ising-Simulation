function [list1,b1,bg1,list2,b2,bg2] = kbd(v,W,beta,g,check)

w = get_ww(W); sz = size(w); sz = sz(1:end-1); shade = ~check(1,1);
w = get_frus(v,w);
b = 1-exp(-4*beta);

wp = wp_to_w(w,check,1); wp = (wp==-1); v = sum(wp,3)==1;
wp1 = circshift(wp,1,3); wp2 = circshift(wp,2,3); wp3 = circshift(wp,3,3);
blist = floor(b+rand(sz,'single')); 
[list2,b2,bg2] = get_sclus(dual(v.*blist,shade));

alist = floor(g+rand(sz,'single'))&blist; blist = blist-alist;
clist = round(rand(sz,'single'));
alist = repmat(alist,[1 1 4]); blist = repmat(blist,[1 1 4]); clist = repmat(clist,[1 1 4]);

wp = alist.*(wp1+wp3) + blist.*(wp2+wp1+clist.*(wp3-wp1));
w = wp_to_w(wp,check,0);
[list1,b1,bg1] = get_bclus(w,false);

end
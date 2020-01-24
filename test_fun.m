clear all;

n = 20;
m = 20;
scale = 100;
n_loops = 100;
loop_ratio = Inf;
vers = 0;
frus = 0.24;
sz = 0.5;

[w,v,h,E,cost] = gen_abW(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
v*w*h.'
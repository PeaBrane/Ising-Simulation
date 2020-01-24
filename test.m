clear all;
rng(0);

scale = 100; 
frus = 0.15;
loop_ratio = Inf; 
vers = 1; 

n = 30;
m = 30;

density = 5;
n_loops = floor(n*density);

sz = 0.5;

[w,v,h,E,cost] = gen_abW(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
a = zeros(1,n); b = zeros(1,m);
generate_SAT(a,b,w,cost);
clear all;

n = 40;
m = 40;
scale = 100;
frus = 0.22;
n_loops = 800;

boolist = zeros(1,200);
for iter = 1:200
W = loop_rand(n,m,scale,frus,n_loops);
v = ones(1,n); h = ones(1,m);
boolist = sum(W(:)) == v*W*h.';
end
all(boolist)
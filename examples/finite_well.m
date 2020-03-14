clear;
addpath(genpath('..'));

sz = [50 50];
szw = [1 25];
depth = 20;
k1 = 1;
k2 = 25;

H = well(sz,szw,depth,-5);
H = gpuArray(H); [v,d] = eig(H); v = gather(v);
v = reshape(v(:,k1:k2), [sz k2-k1+1]);
% v = load('data.mat'); v = v.v; v = v(:,:,1:k);
greyplot(v,0);
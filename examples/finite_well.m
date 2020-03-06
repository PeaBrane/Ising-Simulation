clear;
addpath(genpath('..'));

sz = [50 50];
szw = [5 10];
depth = 20;
k = 100;

H = well(sz,szw,depth,-5);
H = gpuArray(H); [v,d] = eig(H); v = gather(v);
v = reshape(v(:,1:k), [sz k]);
% v = load('data.mat'); v = v.v; v = v(:,:,1:k);
greyplot(v.^2,0);
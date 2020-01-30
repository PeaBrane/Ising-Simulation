clear;
rng(0)

n_list = [30];
vers_list = [1];
sz_list = [0.5:0.1:0.8];

frus_list = [0.22];
density_list = 0.1*1.12.^[1:1:60];

scale = 100;
loop_ratio = Inf;

runs = 10000;
dev = 0;
cap = 9;

folder = '01_29_1';

solve_parallel(folder,n_list,vers_list,sz_list,frus_list,density_list,scale,loop_ratio,runs,dev,cap);
% timelist = myread(folder,n_list,vers_list,sz_list,frus_list,density_list,runs);
% myplot(density_list, timelist, 95, true);
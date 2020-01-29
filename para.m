clear;
rng(0)

n_list = [30];
vers_list = [1];
sz_list = [0.5 0.6];

frus_list = [0.22];
density_list = 0.1*1.12.^[2:2:40];

scale = 100;
loop_ratio = Inf;

runs = 400;
dev = 0;
cap = 9;

time_list = solve(n_list,vers_list,sz_list,frus_list,density_list,scale,loop_ratio,runs,dev,cap);

myplot(density_list, time_list, 95, true);
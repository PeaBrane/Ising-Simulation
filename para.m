clear;
rng(0)

n_list = [30];
vers_list = [0];
sz_list = [0.5];

frus_list = [0.18];
density_list = 0.1*1.12.^[0.5:0.5:20];

scale = 100;
loop_ratio = Inf;

beta_smart = true;
dev = 0;
cap = 9;
perc = 80;

% folder = 'C:\Users\Rudy\Desktop\Coding\Matlab\Plant_data\';
% folder = '02_03_1/';
runs = 100;
workers = 100;

varlist = {density_list frus_list sz_list vers_list n_list};

timelist = solve(scale,loop_ratio,runs,dev,cap,perc,varlist,beta_smart);
% solve_parallel(folder,workers,runs,dev,cap,scale,loop_ratio,varlist,beta_smart);
% timelist = myread(strcat(folder,'01_30_2'),workers,runs,varlist);
% save(strcat(folder,'02_03_struct_lowf\data.mat'),'timelist');
% timelist = load(strcat(folder,'02_03_struct_lowf\data.mat'));
% timelist = timelist.timelist;
% timelist = reshape(timelist, [runs length(density_list) length(sz_list)]);

legendcell = get_legend('size', sz_list);
myplot(density_list, timelist, [30 50 70], true, legendcell);
% This example compares the hardness scaling behaviors of the random and
% structured loop algorithms.

clear;
rng(0);
addpath(genpath('..'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Parameters for Generation %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_list = [30]; % system sizes
vers_list = [0 1]; % versions
sz_list = [0.5]; % upper block sizes
loop_ratio = Inf; % center loop ratio

frus_list = [0.20]; % frustration indices
density_list = 0.1*1.12.^[20:0.5:40]; % densities

scale = 100; % scale of loop weights

% collecting the parameters
varlist = {density_list frus_list sz_list vers_list n_list};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Parameters for Solution %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beta_smart = true;
dev = 0; % allowed tolerance for solution
cap = 9;
perc = 80; % desired percentile
runs = 100; % number of instances per class

timelist = solve(scale,loop_ratio,runs,dev,cap,perc,varlist,beta_smart);
timelist = reshape(timelist, [runs length(density_list) length(vers_list)]);

legendcell = get_legend('Version', vers_list);
myplot(density_list, timelist, [30 50 70], true, legendcell);
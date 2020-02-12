% This example generates a tiling instance and tries to solve it with SA.

clear;
addpath(genpath('..'));

% Tiling Parameters
n = 6; 
m = 6; 
k = 6;
flist = [0 0 0 0 1];
N = n*m*k;

% SA Parameters
beta_list = [0.01 log(N)]; % inverse temperature schedule
T = 10^7;
t = 10^5;

fprintf('Generating instance...');
fprintf('\n');
[w,Esol,cost] = tiling_3d(n,m,k,flist); % generates instance
w = gauge_lattice(w); % gauges instance

% solves instance and
% returns best energy found as 'Ebest', and TTS as 'tot'
fprintf('Solving instance');
[tot,Ebest] = SA_lattice(Esol,w,beta_list,T,t);
fprintf('\n');
fprintf(strcat('TTS: ', num2str(tot), ' sweeps'));
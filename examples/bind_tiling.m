clear;
addpath(genpath('..'));
% Note: simulation is parallelized

% Tiling Parameters
npara = [4 6 0]; % from 4x4x4 to 6x6x6 3d lattice
flist = [0 0 0 0 1]; % tiling cube ratios
fRBM = false; % non-RBM structure

% Algorithm
falgo = [1 0.5]; % [PT mode, replicated without ICM]
betapara = [0.5 4]; % inverse temperature range
nr = 30; % number of replicas
conf = []; % random spin initialization
vars = [betapara nr];

% Simulation
T = 2^10; % total simulation time
tw = 2^9; % waiting time
runs = 2^5;
monitor = [0 1 0]; % [quiet record save] 

[~,para,state] = statistics(vars,falgo,npara,flist,fRBM,runs,T,tw,monitor); % run simulation
smartplot(para.betalist,state.bind,[],[1 0],[],[],[],[],[]); % plot binder curves
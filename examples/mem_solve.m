clear;
addpath(genpath('..'));

% Tiling Parameters
sz = [6 6 6]; % 6x6x6 3D lattice
flist = [0 0 0 0 1]; % tiling cube ratios 
fRBM = false; % non-RBM structure

% Algorithm
falgo = [2 1]; % [bond-based memory, double precision]
alpha = 0.799; beta = 1.040; gamma = 0.836; delta = 7.068; zeta = 2.201; % time-scale parameters
xini = 0.683; % memory initial value
conf = []; % random spin initialization
t = 6.192; % time before restart 
dt = -3.184; % maximum stepsize
vars = [alpha beta gamma delta zeta xini t dt];

% Simulation
T = 2^12; % total simulation time
monitor = [0 0 0]; % [quiet record save] 

[W,Esol] = tiling(sz,flist); % generates instance
Ebest = mem(vars,falgo,Esol,W,fRBM,T,[],monitor); % tries to solve the instance

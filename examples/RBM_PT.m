clear;
addpath(genpath('..')); 
cmap = cbrewer('qual','Set2',8,'PCHIP');
colormap(cmap);

% RBM Parameters

sz = [40 40]; % 40x40 RBM
frus = 11; % random RBM handle, a value between [0 0.25] will generate loop instances
fRBM = true; % RBM mode

% Spin-flip Parameters

betapara = [0.1 10]; % a geometric series of temperatures from 0.1 to 10 with nr=30 replicas
nr = 30;
icm = false; % do not employ the icm (Houdayer) cluster update schedule

% Run Parameters

npara = [40 50]; % run RBM sized from 40x40 to 60x60
T = 2^10; % total simulation time
tw = 2^9; % wait time before recording statistics

runs = 100; % total number of distinct instance
monitor = [0 1 0]; %[quiet record save]

% main

[Nlist,tlist,ttlist,betalist,normsz,Ediff,lap,clus] = statistics([betapara nr],icm,npara,11,fRBM,runs,T,tw,monitor);
lbs = {'beta','U/N'}; lgs = {'40x40','45x45','50x50'};
smartplot(betalist,Ediff,[50 50 50],[true true],false,'Random RBM',lbs,lgs);
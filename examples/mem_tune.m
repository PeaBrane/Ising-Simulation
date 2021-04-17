%%%%% tune memory parameters based on simplex descent in parameter space
%%%%% note: uses parallel processes
clear;
addpath(genpath('..')); 

%%%%% PARAMETERS %%%%%
varsmem = [0.799 1.040 0.836 7.068 2.201 0.683 6.192 -3.184]; % current best parameters for memory
varlb = [0 0 0 0 0 0 4 -5]; % parameter lower bounds
varub = [2 2 2 1 5 1 10 -2]; % parameter upper bounds
indices = [1:8]; % tune over all 8 indices
falgo = [2 2]; % first 2: memory; second 2: double precision
sz = [30 30]; % size of the RBM
flist = 11; % code 11 = gaussian distribution
fRBM = true; % RBM instances
steps = 10; % 10 simplex steps
runs = 10; % 10 random instances per step
T = 2^10; % simulation time
conf = [];
monitor = [0 0 0];
fSA = 0; % method of parameter searching; false=simplex descent; true=simulated annealing
fAPX = 0; % leave 0 if solution unknown
gap = 0; % leave 0 if solution unknown

var = tuning(varsmem,varlb,varub,indices,falgo,sz,flist,fRBM,steps,runs,T,conf,monitor,fSA,fAPX,gap);
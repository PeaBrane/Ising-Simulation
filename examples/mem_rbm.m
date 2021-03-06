%%%%% compare the performance of memory dynamics and simulated annealing
%%%%% in finding the ground state of a random RBM
clear;
addpath(genpath('..')); 

%%%%% PARAMETERS %%%%%
varsmem = [0.799 1.040 0.836 7.068 2.201 0.683 6.192 -3.184]; % current best parameters for memory
varssto = [0.1 10 30]; % parameters for stochastic algorithms [beta_lowest beta_highest #_of_replicas]

%%%%% RUN PARAMETERS %%%%%
falgo = [2 2]; % first 2: memory; second 2: double precision
Esol = 0; % 0 if E_gs not known in advance
fRBM = true; % true because running RBM instances
T = 2^10; % simulation time
tw = 0; % waiting time for equilibrium
conf = []; % empty if random initialization
monitor = [0 0 0]; % [quiet=false record=false save=false];


% Generate a Gaussian RBM
W = normrnd(0,1,[30 30]);

% Compare memory dynamics with SA
Ebest1 =  SA(varssto,Esol,W,fRBM,T,tw,monitor);
Ebest2 = mem(varsmem,falgo,Esol,W,fRBM,T,conf,monitor);
fprintf('\n');
fprintf(strcat('Best energy found by SA: ',num2str(-Ebest1),'\n',...
        strcat('Best energy found by memory: '),num2str(-Ebest2)));
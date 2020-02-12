clear;
rng(0)
addpath(genpath('cnf'),genpath('display'),genpath('generators'),genpath('parallel'),genpath('solvers'),genpath('utils'));

n = 6; 
m = 6; 
k = 6;
flist = [0 0 0 0 1];
% density = 0.3;
% ll = 6;
N = n*m*k;

% SA
beta_list = [0.01 log(N)];
T = 10^7;
t = 10^5;

% PT
% T = 100000;
% t = 10000;
% replicas = ceil(0.0183*N + 0.7);
% beta_list = geoseries(0.01,log(N),replicas);
% N_configs = 2;

% Forrest
% gamma = 0.25;
% epsilon = 0.01;
% T = 50000;
% t = 10000;
% dt = [2^-6 2^-3];
% beta = 0.05;
% rigid = 2;

% Sean
% alpha = 0.4;
% beta = 5;
% rho = 0.2;
% Nsteps = 1000000;
% dt = [2^-6 2^-4];

runs = 100;
perc = 60;

[w,Esol,cost] = tiling_3d(n,m,k,flist);
w = gauge_lattice(w);

% generate_SAT_3d(w,cost);

% wlist = zeros(n,m,k,3,runs); Elist = zeros(1,runs);
% for run = 1:runs
% [w,Esol,cost] = d3plaq_bonds(n,m,k,flist);
% w = gauge(w);
% wlist(:,:,:,:,run) = w; Elist(run) = Esol;
% end

% [tot,Ebest] = mem(Esol,w,beta,gamma,epsilon,rigid,dt,t,3);
% plot(E_sol-rec);

% timelist = get_timelist(runs,perc,wlist,Elist,beta,gamma,epsilon,rigid,dt,t);
% save('data.mat','timelist');

% [v,xf,xs,E_best] = sean(E_sol,W,alpha,beta,rho,Nsteps,dt,3);

% [w,E_sol] = d3plaq_bonds(n,m,k,flist);
% W = get_W_3d(w);

% [v,Ebest] = PT_iso(E_sol,W,beta_list,T,t);
% [v,Ebest] = PT_3d(E_sol,W,beta_list,T,t);
[tot,E_best] = SA_lattice(Esol,w,beta_list,T,t);
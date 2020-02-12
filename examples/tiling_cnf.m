% This example generates 10 instances of 6x6x6 Ising instances with F6
% tiling cubes, and converts them to cnf files.

clear;
rng(0);
addpath(genpath('..'));

sz = [6 6 6];
flist = [0 0 0 0 1];
runs = 10;

generate_tiling_cnf(sz,flist,runs);
function [clus,cor,Emean] = cluster(sz,flist,beta,gamma,runs,T,tw,falgo)

tw = 2^tw;
cor = zeros(1,T-tw);
Elist = zeros(runs,T);
Emean = zeros(runs,T);
clus = zeros(T,runs);

fsweep = falgo(1); fwolff = falgo(2); fkbd = falgo(3);
if fkbd
    check = checkerboard(sz,0);
end

for run = 1:runs
[W,Esol] = tiling(sz,flist);
v = -1+2*round(rand(sz));
[~,field,~,E,~] = get_E(v,W,W,false);
for dt = 1:T

if fsweep
[v,~,~] = sweep_lattice(v,W,field,E,beta);
inds = 0;
end
if fwolff
[inds,clus(dt,run)] = wolff(v,W,beta,gamma);
end
if fkbd
[inds,clus(dt,run)] = kbd(v,W,beta,gamma,check);
end
if inds
v(inds.') = -v(inds.');
end

[~,field,~,E,~] = get_E(v,W,W,false);
if dt == tw
v0 = v;
end
if dt > tw
cor(dt-tw) = cor(dt-tw) + sum(v.*v0,'all');
end
Elist(run,dt) = Esol-E;
Emean(run,dt) = mean(Elist(run,1:dt),2);

end
mydot(run,runs,1,1);
end

clus = permute(median(clus,2),[2 1]);
cor = cor/prod(sz)/runs;
Emean = mean(Emean,1);

end
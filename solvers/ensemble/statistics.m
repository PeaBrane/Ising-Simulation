function [Nlist,tlist,ttlist,betalist,normsz,Ediff,lap,clus] = statistics(vars,falgo,npara,flist,fRBM,runs,T,tw,monitor)

betapara = vars(1:2); nr = vars(3); betalist = geoseries(betapara(1),betapara(2),nr);
[algo,fname] = get_suffix(fRBM,falgo);
fname = strcat('mul_',fname,'.mat');
if strcmp(algo,'mem')
t0 = floor(2^vars(7)); tw = floor(tw); T = ceil(T/t0)*t0;
end

[Nlist,nmk] = get_nmk(npara,fRBM); ins = length(Nlist);
tots = ins*runs;
normsz = cell(1,ins);
for in = 1:ins
   N = Nlist(in);
   normsz{in} = (1:N)/N;
end
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
ttlist = unique(round(geoseries(1,T,10*round(log2(T))))); rrecs = length(ttlist);
if strcmp(algo,'SA') || strcmp(algo,'PT')
Ediff = zeros(tots,nr); lap = zeros(tots,recs,nr);
elseif strcmp(algo,'ICM')
Ediff = zeros(tots,2,nr); lap = zeros(tots,recs,2,nr);
elseif strcmp(algo,'mem')
Ediff = zeros(tots,rrecs); lap = zeros(tots,recs);
end
clus = cell(1,tots);
fsave = monitor(3);

if strcmp(algo,'SA') || strcmp(algo,'PT')
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
if strcmp(algo,'SA')
[~,~,state] = SA(vars,Esol,W,fRBM,T,tw,falgo,[1 1 0]);
else
[~,~,~,state] = PT(vars,Esol,W,fRBM,T,tw,[],[1 1 0]);  
end
Ediff(tot,:) = state.E; lap(tot,:,:) = state.lap; clus{tot} = state.clus; 
end
Ediff = mean(permute(reshape(Ediff,[runs ins nr]),[1 3 2]),1);
lap = mean(permute(reshape(lap,[runs ins recs nr]),[1 3 4 2]),1);
clus = cellmean(reshape(clus,[runs ins])); 
if fsave
save(fname,'Nlist','tlist','betalist','normsz','Ediff','lap','clus');
end 

elseif strcmp(algo,'ICM')
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,state] = PTI(vars,Esol,W,fRBM,T,tw,[],[1 1 0]);
Ediff(tot,:,:) = state.E; lap(tot,:,:,:) = state.lap; clus{tot} = state.clus; 
end
Ediff = permute(reshape(mean(reshape(Ediff,[runs ins 2 nr]),[1 3]),[1 ins nr]),[1 3 2]);
lap = permute(reshape(mean(reshape(lap,[runs ins recs 2 nr]),[1 4]),[1 recs ins nr]),[1 2 4 3]);
clus = cellmean(reshape(clus,[runs ins]));
if fsave
save(fname,'Nlist','tlist','betalist','normsz','Ediff','lap','clus');
end  

elseif strcmp(algo,'mem')
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,~,state] = mem(vars,Esol,W,fRBM,T,tw,[],[1 1 0]);
Ediff(tot,:) = state.E; lap(tot,:) = state.lap; clus{tot} = state.clus; 
end
Ediff = mean(permute(reshape(Ediff,[runs ins rrecs]),[1 3 2]),1);
lap = mean(permute(reshape(lap,[runs ins recs]),[1 3 2]),1);
clus = cellmean(reshape(clus,[runs ins])); 
if fsave
save(fname,'Nlist','tlist','betalist','normsz','Ediff','lap','clus');
end  
end

end
function [Nlist,tlist,betalist,normsz,Ediff,lap,clus] = PT_mul(betapara,nr,icm,npara,flist,runs,T,tw,fRBM,monitor)

betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
betahigh = betalist(find(betalist > 1,1,'first'):end); bhl = length(betahigh);
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);
normsz = cell(1,ins);
for in = 1:ins
   N = Nlist(in);
   normsz{in} = (1:N)/N;
end

quiet = monitor(1); record = monitor(2); fsave = monitor(3);
tots = runs*ins;
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
if ~icm
Ediff = zeros(tots,bl);
lap = zeros(tots,recs,bl);
algo = 'PT';
else
Ediff = zeros(tots,2,bl);
lap = zeros(tots,recs,2,bl);
algo = 'ICM';
end
if fRBM
algo = strcat(algo,'_RBM'); 
end
clus = cell(1,tots);

if ~icm
parfor tot = 1:tots
in = fix((tot-1)/runs)+1;
sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist); 
else
[W,Esol] = rbmloops(sz,0.31,flist); 
end
[~,~,~,state] = PT(betapara,nr,Esol,W,T,tw,fRBM,[],[1 record 0]);
Ediff(tot,:) = state.E; lap(tot,:,:) = state.lap;
end
else
parfor tot = 1:tots
in = fix((tot-1)/runs)+1;
sz = nmk(in,:);
[W,Esol] = tiling(sz,flist);    
[~,~,~,state] = PTI(betapara,nr,Esol,W,T,tw,[],[1 record 0]);
Ediff(tot,:,:) = state.E; lap(tot,:,:,:) = state.lap; clus{tot} = state.clus;
end
end

if ~icm
Ediff = mean(permute(reshape(Ediff,[runs ins bl]),[1 3 2]),1);
lap = mean(permute(reshape(lap,[runs ins recs bl]),[1 3 4 2]),1);
else
Ediff = permute(reshape(mean(reshape(Ediff,[runs ins 2 bl]),[1 3]),[1 ins bl]),[1 3 2]);
lap = permute(reshape(mean(reshape(lap,[runs ins recs 2 bl]),[1 4]),[1 recs ins bl]),[1 2 4 3]);
clus = cellmean(reshape(clus,[runs ins]));
end
if fsave
save(strcat(algo,'_mul.mat'),'tlist','Nlist','betalist','normsz','Ediff','lap','clus');
end   

end
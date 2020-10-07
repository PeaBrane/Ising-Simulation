function [Nlist,tlist,betalist,normsz,Ediff,lap,clus] = SA_mul(betapara,nr,npara,flist,runs,T,tw,fRBM,falgo,monitor)

betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
if ~fRBM
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);
else
nmk = repmat((npara(1):5:npara(2)).',[1 2]);
Nlist = sum(nmk,2).';
ins = size(nmk,1);
end
normsz = cell(1,ins);
for in = 1:ins
   N = Nlist(in);
   normsz{in} = (1:N)/N;
end

quiet = monitor(1); record = monitor(2); fsave = monitor(3);
tots = ins*runs; 
tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(tlist);
Ediff = zeros(tots,bl);
lap = zeros(tots,recs,bl);
if falgo(3)
algo = 'KBD';
elseif falgo(2)
algo = 'Wolff';
elseif falgo(1)
algo = 'SA';
end
if fRBM
algo = strcat(algo,'_RBM'); 
end
clus = cell(1,tots);

parfor tot = 1:tots
in = fix((tot-1)/runs)+1;
sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,state] = SA(betapara,nr,Esol,W,T,tw,fRBM,falgo,[1 record 0]);
Ediff(tot,:) = state.E; lap(tot,:,:) = state.lap; clus{tot} = state.clus;
end

Ediff = mean(permute(reshape(Ediff,[runs ins bl]),[1 3 2]),1);
lap = mean(permute(reshape(lap,[runs ins recs bl]),[1 3 4 2]),1);
clus = cellmean(reshape(clus,[runs ins]));
if fsave
save(strcat(algo,'_mul.mat'),'Nlist','tlist','betalist','normsz','Ediff','lap','clus');
end   

end
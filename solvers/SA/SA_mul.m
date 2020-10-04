function [Nlist,betalist,normsz,Ediff,lap,clus] = SA_mul(betapara,nr,npara,flist,runs,T,tw,fRBM,falgo,monitor)

betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

quiet = monitor(1); record = monitor(2); fsave = monitor(3);
Ediff = zeros(runs,T-tw,bl,ins);
lap = zeros(runs,T-tw,bl,ins);
normsz = cell(1,ins); clus = cell(1,ins);

if falgo(3)
algo = 'KBD';
elseif falgo(2)
algo = 'Wolff';
elseif falgo(1)
algo = 'SA';
end

for in = 1:ins
sz = nmk(in,:); N = prod(sz);
normsz{in} = (1:N)/N;
cl = zeros(runs,N);

parfor run = 1:runs
[W,Esol] = tiling(sz,flist);  
[~,~,state] = SA(betapara,nr,Esol,W,T,tw,fRBM,falgo,[1 record 0]);
Ediff(run,:,:,in) = state.E; 
lap(run,:,:,in) = state.lap;
cl(run,:) = state.clus(:,:,1);
end
clus{in} = normalize(mean(cl,1),2,'norm',1);

if ~quiet
fprintf('\n');
fprintf(strcat(algo,': '));
fprintf(num2str(sz));
end
end

lap = reshape(mean(lap,1),[1 (T-tw) bl ins]);
Ediff = mean(reshape(Ediff,[runs*(T-tw) bl ins]),1);
if fsave
save(strcat(algo,'_mul.mat'),'Nlist','betalist','normsz','Ediff','lap','clus');
end   

end
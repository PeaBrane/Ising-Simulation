function [Nlist,betalist,normsz,Ediff,lap,clus] = PT_mul(betapara,nr,icm,npara,flist,runs,T,tw,monitor)

betalist = geoseries(betapara(1),betapara(2),nr); bl = length(betalist);
betahigh = betalist(find(betalist > 1,1,'first'):end); bhl = length(betahigh);
nmk = get_nmk(npara(1),npara(2));
Nlist = prod(nmk,2).';
ins = size(nmk,1);

quiet = monitor(1); record = monitor(2); fsave = monitor(3);
if ~icm
Ediff = zeros(runs,T-tw,bl,ins);
lap = zeros(runs,T-tw,bl,ins);
algo = 'PT';
else
Ediff = zeros(runs,T-tw,2,bl,ins);
lap = zeros(runs,T-tw,2,bl,ins);
algo = 'ICM';
end
normsz = cell(1,ins);

for in = 1:ins
sz = nmk(in,:); N = prod(sz);
if icm
    normsz{in} = (1:N)/N;
end
if in == ins
    clus = zeros(runs,N,bhl);
end

if ~icm
parfor run = 1:runs
[W,Esol] = tiling(sz,flist);  
[~,~,~,~,state] = PT(betapara,nr,Esol,W,T,tw,[],[],[1 record 0]);
Ediff(run,:,:,in) = state.E; 
lap(run,:,:,in) = state.lap;
end
else
parfor run = 1:runs
[W,Esol] = tiling(sz,flist);  
[~,~,~,~,state] = PTI(betapara,nr,Esol,W,T,tw,[],[],[1 record 0]);
Ediff(run,:,:,:,in) = state.E; 
lap(run,:,:,:,in) = state.lap;
if in == ins
clus(run,:,:) = state.clus; 
end
end
end

if ~quiet
fprintf('\n');
fprintf(strcat(algo,': '));
fprintf(num2str(sz));
end
end

if ~icm
lap = mean(lap,1);
Ediff = mean(reshape(Ediff,[runs*(T-tw) bl ins]),1);
else
lap = reshape(mean(lap,[1 3]),[1 (T-tw) bl ins]);
Ediff = mean(reshape(Ediff,[runs*(T-tw)*2 bl ins]),1);
clus = normalize(mean(clus,1),2,'norm',1);
end
if fsave
save(strcat(algo,'_mul.mat'),'Nlist','betalist','normsz','Ediff','lap','clus');
end   

end
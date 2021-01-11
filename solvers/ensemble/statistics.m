function [para,state] = statistics(vars,falgo,npara,flist,fRBM,runs,T,tw,monitor)

betapara = vars(1:2); nr = vars(3);
fsave = monitor(3);
[falgo,algo,flist,fname] = get_suffix(falgo,npara,flist,fRBM);
fname = strcat('stat',fname,'.mat');

nt = T; dt = 1;
if strcmp(algo,'mem')
t0 = floor(2^vars(7)); nr = ceil(T/t0);
dt = 2^-5; nt = round(t0/dt); 
end

[Nlist,nmk] = get_nmk(npara,fRBM); ins = length(Nlist);
tots = ins*runs;
normsz = cell(1,ins);
for in = 1:ins
   N = Nlist(in);
   normsz{in} = (1:N)/N;
end

para = struct;
para.Nlist = Nlist;
para.normsz = normsz;
para.tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(para.tlist);
para.wlist = (0:nt-1)/nt/dt*2*pi;
para.betalist = geoseries(betapara(1),betapara(2),nr);

state = struct;
state.Ediff = zeros(1,nr,ins);
state.dlap = zeros(1,recs,nr,ins);
state.pmag = zeros(1,nr,ins);
state.sclus = cell(1,tots);
state.bclus = cell(1,tots);

if strcmp(algo,'ICM')
state.Ediff = zeros(tots,2,nr); 
state.dlap = zeros(tots,recs,2,nr);
end
if strcmp(algo,'mem')
state.vspec = zeros(tots,nt,nr);
state.xspec = zeros(tots,nt,nr);
end

% Simulated Annealing
if strcmp(algo,'SA')
Ediff = zeros(tots,nr); dlap = zeros(tots,recs,nr); sclus = cell(1,tots);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,st] = SA(vars,falgo,Esol,W,fRBM,T,tw,[1 1 0]);
Ediff(tot,:) = st.E; dlap(tot,:,:) = st.dlap; sclus{tot} = st.sclus; 
end
state.Ediff = mean(permute(reshape(Ediff,[runs ins nr]),[1 3 2]),1);
state.dlap = mean(permute(reshape(dlap,[runs ins recs nr]),[1 3 4 2]),1);
state.sclus = cellmean(reshape(sclus,[runs ins])); 
if fsave
save(fname,'state');
end 

% Parallel Tempering
elseif strcmp(algo,'PT')
Ediff = zeros(tots,nr); dlap = zeros(tots,recs,nr); sclus = cell(1,tots);
pmag = zeros(tots,nr);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,st] = PT(vars,falgo,Esol,W,fRBM,T,tw,[],[1 1 0]);
Ediff(tot,:) = st.E; pmag(tot,:) = st.pmag;
dlap(tot,:,:) = st.dlap; sclus{tot} = st.sclus; bclus{tot} = st.bclus;
end
state.Ediff = mean(permute(reshape(Ediff,[runs ins nr]),[1 3 2]),1);
state.pmag = mean(permute(reshape(pmag,[runs ins nr]),[1 3 2]),1);
state.dlap = mean(permute(reshape(dlap,[runs ins recs nr]),[1 3 4 2]),1);
state.sclus = cellnorm(cellmean(reshape(sclus,[runs ins]))); 
state.bclus = cellnorm(cellmean(reshape(bclus,[runs ins]))); 
if fsave
save(fname,state);
end

% Isoenergetic Cluster Move
elseif strcmp(algo,'ICM')
Ediff = zeros(tots,2,nr); dlap = zeros(tots,recs,2,nr); sclus = cell(1,tots);    
for tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,st] = PTI(vars,Esol,W,fRBM,T,tw,[],[1 1 0]);
Ediff(tot,:,:) = st.E; dlap(tot,:,:,:) = st.dlap; sclus{tot} = st.sclus; 
end
state.Ediff = permute(reshape(mean(reshape(Ediff,[runs ins 2 nr]),[1 3]),[1 ins nr]),[1 3 2]);
state.dlap = permute(reshape(mean(reshape(dlap,[runs ins recs 2 nr]),[1 4]),[1 recs ins nr]),[1 2 4 3]);
state.sclus = cellnorm(cellmean(reshape(sclus,[runs ins])));
if fsave
save(fname,'state');
end  

% Memory
elseif strcmp(algo,'mem')
bclus = cell(1,tots); vspec = zeros(tots,nt,nr); xspec = zeros(tots,nt,nr);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,~,st] = mem(vars,Esol,W,fRBM,T,[],[1 1 0]);
bclus{tot} = st.bclus; vspec(tot,:,:) = st.vspec; xspec(tot,:,:) = st.xspec;
end
state.bclus = cellnorm(cellmean(reshape(bclus,[runs ins]))); 
state.vspec = mean(permute(reshape(vspec,[runs ins nt nr]),[1 3 4 2]),1);
state.xspec = mean(permute(reshape(xspec,[runs ins nt nr]),[1 3 4 2]),1);
if fsave
save(fname,'state');
end  
end

end
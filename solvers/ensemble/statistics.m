function [fname,para,state] = statistics(vars,falgo,npara,flist,fRBM,runs,T,tw,conf,monitor)

para = struct;
betapara = vars(1:2); nr = vars(3);
fsave = monitor(3);
[falgo,algo,flist,fname] = get_suffix(falgo,npara,flist,fRBM,vars);
fname = strcat('stat',fname,'.mat');

nt = T; dt = 1;
if strcmp(algo,'mem')
t0 = floor(2^vars(7)); nr = ceil(T/t0); T = t0*nr;
dt = 2^-5; nt = round(t0/dt); 
rlist = unique(round(geoseries(1,nr,10*round(log2(nr))))); nr = length(rlist);
para.rlist = rlist*t0;
end

[Nlist,nmk] = get_nmk(npara,fRBM); ins = length(Nlist);
tots = ins*runs;
normsz = cell(1,ins); normq = cell(1,ins);
for in = 1:ins
   N = Nlist(in);
   normsz{in} = (1:N)/N; normq{in} = (-N:N)/N;
end
if ~isempty(conf)
Wlist = conf{1}; Elist = conf{2};
else
Wlist = cell(1,tots); Elist = zeros(1,tots);
end

para.Nlist = Nlist;
para.normsz = normsz; para.normq = normq;
para.tlist = unique(round(geoseries(1,(T-tw),10*round(log2(T-tw))))); recs = length(para.tlist);
para.ttlist = unique(round(geoseries(1,(T),10*round(log2(T))))); rrecs = length(para.ttlist);
para.wlist = (0:nt-1)/nt/dt*2*pi;
para.betalist = geoseries(betapara(1),betapara(2),nr);
if strcmp(algo,'PT')
    para.ttlist = para.ttlist*nr;
elseif strcmp(algo, 'ICM')
    para.ttlist = para.ttlist*2*nr;
end

state = struct;

% Simulated Annealing
if strcmp(algo,'SA')
Et = zeros(tots,rrecs); Eb = zeros(tots,rrecs);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~isempty(Wlist{tot})
W = Wlist{tot}; Esol = Elist(tot);
elseif ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,st] = SA(vars,Esol,W,fRBM,T,tw,[1 1 0])
Et(tot,:) = st.Et; Eb(tot,:) = st.Eb;
end
state.Et = permute(reshape(Et,[runs ins rrecs]),[1 3 2]);
state.Eb = permute(reshape(Eb,[runs ins rrecs]),[1 3 2]);
if fsave
save(fname,'para','state');
end  

% Parallel Tempering
elseif strcmp(algo,'PT')
E = zeros(tots,nr); Et = zeros(tots,nr,rrecs); Eb = zeros(tots,rrecs);
dlap = zeros(tots,nr,recs); 
cor = cell(1,tots); con = cell(1,tots); cort = cell(1,tots); cont = cell(1,tots);
bclus = cell(1,tots);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~isempty(Wlist{tot})
W = Wlist{tot}; Esol = Elist(tot);
elseif ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,st] = PT(vars,falgo,Esol,W,fRBM,T,tw,[],[1 1 0]);
E(tot,:) = st.E; Et(tot,:,:) = st.Et; Eb(tot,:) = st.Eb;
dlap(tot,:,:) = st.dlap;
cor{tot} = st.cor; con{tot} = st.con; cort{tot} = st.cort; cont{tot} = st.cont;
bclus{tot} = st.bclus;
end 

state.E = permute(mean(reshape(E,[runs ins nr]),1),[1 3 2]);
state.Et = permute(mean(reshape(Et,[runs ins nr rrecs]),1),[1 4 3 2]);
state.Eb = permute(reshape(Eb,[runs ins rrecs]),[1 3 2]);
state.dlap = permute(mean(reshape(dlap,[runs ins nr recs]),1),[1 4 3 2]);

state.cor = cellmean(reshape(cor,[runs ins]));
state.con = cellmean(reshape(con,[runs ins]));
state.cort = cellmean(reshape(cort,[runs ins]));
state.cont = cellmean(reshape(cont,[runs ins]));
state.bclus = cellnorm(cellmean(reshape(bclus,[runs ins])));
if fsave
save(fname,'para','state');
end

% Isoenergetic Cluster Move
elseif strcmp(algo,'ICM')
E = zeros(tots,2,nr); Et = zeros(tots,2,nr,rrecs); Eb = zeros(tots,rrecs);
dlap = zeros(tots,2,nr,recs); q2 = zeros(tots,nr); q4 = zeros(tots,nr);
cor = cell(1,tots); con = cell(1,tots); cort = cell(1,tots); cont = cell(1,tots);
qdist = cell(1,tots); sclus = cell(1,tots);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~isempty(Wlist{tot})
W = Wlist{tot}; Esol = Elist(tot);
elseif ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,st] = PTI(vars,falgo,Esol,W,fRBM,T,tw,[],[1 1 0]);
E(tot,:,:) = st.E; Et(tot,:,:,:) = st.Et; Eb(tot,:) = st.Eb;
dlap(tot,:,:,:) = st.dlap; q2(tot,:) = st.q2; q4(tot,:) = st.q4;
cor{tot} = st.cor; con{tot} = st.con; cort{tot} = st.cort; cont{tot} = st.cont;
qdist{tot} = st.qdist; sclus{tot} = st.sclus;
end
state.E = permute(reshape(mean(reshape(E,[runs ins 2 nr]),[1 3]),[1 ins nr]),[1 3 2]);
state.Et = permute(reshape(mean(reshape(Et,[runs ins 2 nr rrecs]),[1 3]),[1 ins nr rrecs]),[1 4 3 2]);
state.Eb = permute(reshape(Eb,[runs ins rrecs]),[1 3 2]);
state.dlap = permute(reshape(mean(reshape(dlap,[runs ins 2 nr recs]),[1 3]),[1 ins nr recs]),[1 4 3 2]);

q2 = permute(reshape(q2,[runs ins nr]),[1 3 2]); q4 = permute(reshape(q4,[runs ins nr]),[1 3 2]);
state.bind = binder(q2,q4);

state.cor = cellmean(reshape(cor,[runs ins]));
state.con = cellmean(reshape(con,[runs ins]));
state.cort = cellmean(reshape(cort,[runs ins]));
state.cont = cellmean(reshape(cont,[runs ins]));
state.qdist = cellnorm(cellmean(reshape(qdist,[runs ins])));
state.sclus = cellnorm(cellmean(reshape(sclus,[runs ins])));
if fsave
save(fname,'para','state');
end  

% Memory
elseif strcmp(algo,'mem')
Et = zeros(tots,recs); Eb = zeros(tots,recs); bclus = cell(1,tots); 
% vspec = zeros(tots,nt,nr); xspec = zeros(tots,nt,nr);
parfor tot = 1:tots
in = fix((tot-1)/runs)+1; sz = nmk(in,:);
if ~isempty(Wlist{tot})
W = Wlist{tot}; Esol = Elist(tot);
elseif ~fRBM
[W,Esol] = tiling(sz,flist);  
else
[W,Esol] = rbmloops(sz,0.31,flist);
end
[~,~,~,~,st] = mem(vars,falgo,Esol,W,fRBM,T,[],[1 1 0]);
Et(tot,:) = st.Et; Eb(tot,:) = st.Eb; bclus{tot} = st.bclus; 
% vspec(tot,:,:) = st.vspec; xspec(tot,:,:) = st.xspec;
end
state.bclus = cellnorm(cellmean(reshape(bclus,[runs ins]))); 
state.Et = permute(reshape(Et,[runs ins recs]),[1 3 2]);
state.Eb = permute(reshape(Eb,[runs ins recs]),[1 3 2]);
% state.vspec = mean(permute(reshape(vspec,[runs ins nt nr]),[1 3 4 2]),1);
% state.xspec = mean(permute(reshape(xspec,[runs ins nt nr]),[1 3 4 2]),1);
if fsave
save(fname,'para','state');
end  
end

end
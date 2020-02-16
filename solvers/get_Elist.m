function Elist = get_Elist(w,beta,sweeps)

sz = size(w); sz = sz(1:end-1);
W = get_W(w);
v = -1+2*round(rand(sz));
[~,field,E] = get_E(v,W);

Elist = zeros(1,sweeps);

for sweep = 1:sweeps
   
    [v,~,~] = sweep_lattice(v,W,field,E,beta);
    v = wolff(v,w,beta);
    [~,field,E] = get_E(v,W);
    Elist(sweep) = E;
    
    mydot(sweep,sweeps);
    
end

end
function generate_rbm_cnf(n,m,scale,density,loop_ratio,vers,frus,sz,runs)
% generates wcnf files for a given class of instances

a = zeros(1,n); b = zeros(1,m);
n_loops = floor(n*density);

dirname = cnf_dirname([n m], [vers density]);
mkdir(dirname);   

for run = 1:runs

[w,~,cost] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
[c1,c2,w1,w2,wmax,nclause] = rbm_to_sat(n,m,a,b,w);

filename = strcat(dirname,'\instance_',num2str(run),'.wcnf');
fid = fopen(filename,'w'); 
text1 = rbm_comments(n,m,density,cost,nclause,wmax);
text2 = write_maxsat_formula(c1,c2,w1,w2);
text = text1 + text2;
fprintf(fid,text);
fclose(fid);

end

end
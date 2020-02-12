function generate_tiling_cnf(n,m,k,flist,runs)
% generates wcnf files for a given class of instances

dirname = cnf_dirname([n m k], str2num(sprintf('%d', flist)));
mkdir(dirname);   

for run = 1:runs

[w,~,cost] = tiling_3d(n,m,k,flist);
C = lattice_to_sat(w);
nc = size(C,1);

filename = strcat(dirname,'\instance_',num2str(run),'.cnf');
fid = fopen(filename,'w'); 
text1 = tiling_comments(n,m,k,cost,nc);
text2 = write_sat_formula(C);
text = text1 + text2;
fprintf(fid,text);
fclose(fid);

end

end
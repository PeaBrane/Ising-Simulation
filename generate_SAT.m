function generate_SAT(a,b,w,cost)

n = length(a); m = length(b);

[sat_entry, ~, ~, weight_entry] = convert_to_SAT(n,m,a,b,w);
w1 = weight_entry{1,1}.'; w2 = weight_entry{2,1}.'; weight = [w1 w2];
c1 = sat_entry{1,1}; c2 = sat_entry{1,2}; 
wmax = max(weight);
nclause = length(weight);

filename = strcat(num2str(n),'times',num2str(m),'.wcnf');
fid = fopen(filename,'w'); 
text = "c Optimal Cost: " + cost + "\n";
text = text + "p wcnf " + num2str(n+m) + " " + num2str(nclause) + " " + num2str(wmax+1) + "\n";
for i = 1:length(w1)
    index = c1(i,1);
    text = text + num2str(w1(i)) + " " + num2str(index) + " " + num2str(0) + "\n";
end
for i = 1:length(w2)
    index1 = c2(i,1); index2 = c2(i,2);
    text = text + num2str(w2(i)) + " " + num2str(index1) + " " + num2str(index2) + " " + num2str(0) + "\n";
end
fprintf(fid,text);
fclose(fid);

end
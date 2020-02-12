function text = tiling_comments(n,m,k,cost,nclause)

text = "c " + num2str(n) + "x" + num2str(m) + "x" + num2str(k) +  " lattice\n";
text = text + "c Optimal Cost: " + cost + "\n";
text = text + "p cnf " + num2str(n*m*k) + " " + num2str(nclause) + "\n";

end
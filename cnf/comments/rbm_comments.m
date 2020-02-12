function text = rbm_comments(n,m,density,cost,nclause,wmax)

text = "c " + num2str(n) + "x" + num2str(m) + " RBM\n";
text = text + "c Loop Density: " + num2str(density) + "\n";
text = text + "c Optimal Cost: " + cost + "\n";
text = text + "p wcnf " + num2str(n+m) + " " + num2str(nclause) + " " + num2str(wmax+1) + "\n";

end
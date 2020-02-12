function text = write_maxsat_formula(c1,c2,w1,w2)

text = "";
for i = 1:length(w1)
    index = c1(i,1);
    text = text + num2str(w1(i)) + " " + num2str(index) + " " + num2str(0) + "\n";
end
for i = 1:length(w2)
    index1 = c2(i,1); index2 = c2(i,2);
    text = text + num2str(w2(i)) + " " + num2str(index1) + " " + num2str(index2) + " " + num2str(0) + "\n";
end

end
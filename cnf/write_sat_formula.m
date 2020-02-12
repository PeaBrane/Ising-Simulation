function text = write_sat_formula(C)

text = "";
nc = size(C,1);

for c = 1:nc
    index1 = C(c,1); index2 = C(c,2);
    text = text + num2str(index1) + " " + num2str(index2) + " " + num2str(0) + "\n";
end

end
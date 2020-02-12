function c = lattice_to_sat(w)

n = size(w,1); m = size(w,2); k = size(w,3);
indices = gen_indices([n m k]);
indices1 = circshift(indices,-1,1);
indices2 = circshift(indices,-1,2);
indices3 = circshift(indices,-1,3);

c = zeros(n*m*k*6, 2);

for i = 1:n
for j = 1:m
for l = 1:k
        
        index = indices(i,j,l);
        
        index1 = indices1(i,j,l);
        index2 = indices2(i,j,l);
        index3 = indices3(i,j,l);
        
        index4 = (index-1)*6;
                
        if w(i,j,l,1) > 0
            c(index4+1,:) = [index -index1];
            c(index4+2,:) = [-index index1];
        else
            c(index4+1,:) = [index index1];
            c(index4+2,:) = [-index -index1];
        end
        
        if w(i,j,l,2) > 0
            c(index4+3,:) = [index -index2];
            c(index4+4,:) = [-index index2];
        else
            c(index4+3,:) = [index index2];
            c(index4+4,:) = [-index -index2];
        end
        
        if w(i,j,l,3) > 0
            c(index4+5,:) = [index -index3];
            c(index4+6,:) = [-index index3];
        else
            c(index4+5,:) = [index index3];
            c(index4+6,:) = [-index -index3];
        end
   
end
end
end

end
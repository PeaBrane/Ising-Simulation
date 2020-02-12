function c = mysub2ind(list,i,j,l)

n = list(1); m = list(2);
c = (l-1)*n*m + (j-1)*n + i;

end
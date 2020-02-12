function Wp = get_Wp(w)

n = size(w,1); m = size(w,2);
Wp = zeros(n,m,4);
i2_list = mod(1:n,n)+1; j2_list = mod(1:m,m)+1;

for i = 1:n
    i2 = i2_list(i);
    for j = 1:m
        j2 = j2_list(j);
        Wp(i,j,1) = w(i,j,1);
        Wp(i,j,2) = w(i,j,2);
        Wp(i,j,3) = w(i2,j,1);
        Wp(i,j,4) = w(i,j2,2);
    end
end

end
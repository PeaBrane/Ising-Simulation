function [w,E,cost] = tiling_3d(n,m,k,flist)

cdf = to_cdf(flist);
flag = 0;

wcube = zeros(n,m,k,12);
w = zeros(n,m,k,3);

i1list = circshift(1:n,-1);
j1list = circshift(1:m,-1);
l1list = circshift(1:k,-1);

for i = 1:n
for j = 1:m
for l = 1:k
   
    if (mod(i,2) == 1 && mod(j,2) == 1 && mod(l,2) == 1) || (mod(i,2) == 0 && mod(j,2) == 0 && mod(l,2) == 0)
        flag = 1;
    end
    
    if flag
        x = cdf_sample(cdf);
        if x == 1  
            cube = f21();
        elseif x == 2 
            cube = f22();
        elseif x == 3 
            cube = f41();
        elseif x == 4 
            cube = f42();
        elseif x == 5 
            cube = f6();
        end
        wcube(i,j,l,:) = cube;
    end
    
    flag = 0;
    
end
end
end

for i = 1:n
for j = 1:m
for l = 1:k
    
    if (mod(i,2) == 1 && mod(j,2) == 1 && mod(l,2) == 1) || (mod(i,2) == 0 && mod(j,2) == 0 && mod(l,2) == 0)
        flag = 1;
        i1 = i1list(i);
        j1 = j1list(j);
        l1 = l1list(l);
        cube = wcube(i,j,l,:);
        cube = reshape(cube,[1 1 1 12]);
    end
    
    if flag
        w(i,j,l,:) = cube([1 4 9]);
        w(i1,j,l,[2 3]) = cube([2 10]);
        w(i,j1,l,[1 3]) = cube([3 12]);
        w(i,j,l1,[1 2]) = cube([5 8]);
        w(i1,j1,l,3) = cube(11);
        w(i1,j,l1,2)= cube(6);
        w(i,j1,l1,1) = cube(7);
    end
    
    flag = 0;
    
end
end
end

E = sum(w(:));
cost = (sum(abs(w(:)))-E)/2;

end
function [w,E,cost] = tiling_3d(n,m,k,flist)

if flist == 10
    w = ones(n,m,k,3);
    E = sum(w(:));
    cost = (sum(abs(w(:)))-E)/2;
    return;
end
if flist == 11
    cube = f6(); cube = permute(cube,[1 4 3 2]);
    wcube = repmat(cube,[n m k 1]);
    w = wp_to_w(wcube);
    E = sum(w(:));
    cost = (sum(abs(w(:)))-E)/2;
    return;
end

cdf = to_cdf(flist);
wcube = zeros(n,m,k,12);

% n = round(n/2); m = round(m/2); k = round(k/2);
for i = 1:n 
for j = 1:m 
for l = 1:k
   
    if (mod(i,2) && mod(j,2) && mod(l,2)) || (~mod(i,2) && ~mod(j,2) && ~mod(l,2))
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
    
end
end
end
wcube(:,:,:,:) = wcube(:,:,:,[1 4 9 7 2 10 3 6 12 5 8 11]);

w = wp_to_w(wcube,0,0);
E = sum(w(:));
cost = (sum(abs(w(:)))-E)/2;

end
function check = checkerboard(sz,shade)

d = length(sz);

if d == 2

n = sz(1); m = sz(2);
check = reshape([ones(1,n/2); zeros(1,n/2)],[n 1]);
check = repmat([check ~check],[1 m/2]);
if shade
    check = ~check;
end

elseif d == 3
    
n = sz(1); m = sz(2); k = sz(3);
check = reshape([true([1 n/2]); false([1 n/2])],[n 1]);
check1 = repmat([check false(n,1)],[1 m/2]);
check2 = repmat([false(n,1) ~check],[1 m/2]);
if shade
check = check1; check1 = check2; check2 = check;
end
check = repmat(cat(3,check1,check2),[1 1 k/2]);
end

end
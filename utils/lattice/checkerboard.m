function check = checkerboard(sz,shade)

n = sz(1); m = sz(2);
check = reshape([ones(1,n/2); zeros(1,n/2)],[n 1]);
check = repmat([check ~check],[1 m/2]);
if shade
    check = ~check;
end

end
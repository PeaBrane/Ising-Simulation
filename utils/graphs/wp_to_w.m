function w = wp_to_w(wp,check,map)

sz = size(wp); sz = sz(1:end-1); d = length(sz);
if numel(check) == 1
    check = checkerboard(sz,check);
end

if d == 2  
w = wp_2d(wp,check,map);  
elseif d == 3
w = wp_3d(wp,check,map);
end

end
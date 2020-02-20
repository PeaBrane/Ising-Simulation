function spinplot(v)

sz = size(v); d = length(sz);
if d ~= 2
    fprintf('Error');
    return;
end
n = sz(1); m = sz(2);

figure(1);
for i = 1:n
for j = 1:m
    if v(i,j) > 0
        fill([i-1 i i i-1], [j-1 j-1 j j], 'blue');
    elseif v(i,j) < 0
        fill([i-1 i i i-1], [j-1 j-1 j j], 'red');
    end
    hold on;
end
end
hold off;

end
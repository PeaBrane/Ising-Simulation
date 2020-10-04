function p = myplot(ind,list,c,l,f)

low = list(1,:); med = list(2,:); hi = list(3,:);
m = find(low==0,1,'first')-1;
if isempty(m)
    m = length(ind);
end

if f
f = fill([ind(1:m) flip(ind(1:m))],[low(1:m) flip(hi(1:m))],c,'linestyle','none');
set(f,'facealpha',0.4);
hold on;
end
if isempty(l) || ~any(l,'all')
p = plot(ind, med, 'color', c, 'marker', '.', 'markersize', 18, 'linewidth', 2);
hold on;
else
scatter(ind, med, 18, c, 'filled');
hold on;
p = plot(l(1,:), l(2,:), 'color', c, 'linewidth', 2);
hold on;
end

end
function p = myplot(ind,list,c,l,f)

low = list(1,:); med = list(2,:); hi = list(3,:);
m = find((low==0)|(low==-Inf),1,'first')-1;
if isempty(m)
    m = length(ind);
end
% m = length(ind);

if f
fill([ind(1:m) flip(ind(1:m))],[low(1:m) flip(hi(1:m))],c,'linestyle','none','facealpha',0.35);
hold on;
end
% [ind,med] = pop_zero(ind,med);
if isempty(l) || ~any(l,'all')
p = plot(ind, med, 'color', c, 'marker', '.', 'markersize', 14, 'linewidth', 2);
hold on;
else
p = plot(l(1,:), l(2,:), 'color', brighten(c,-0.4), 'linewidth', 2);
hold on;
scatter(ind, med, 18, brighten(c,-0.4), 'filled', 'markerfacealpha', 0.7);
hold on;
end

% p = scatter(ind, med, 18, brighten(c,-0.4), 'filled');
% hold on;

end
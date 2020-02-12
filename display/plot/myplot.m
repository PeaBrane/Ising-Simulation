function myplot(ind_list, time_list, perc, f_log, legendcell)

cmap = cbrewer('qual','Set2',8,'PCHIP');
colormap(cmap);

siz = size(time_list);
dim = length(siz);

perc1 = perc(1); perc2 = perc(2); perc3 = perc(3);

if dim > 3
    fprintf('Cannot Plot');
end

if dim == 2

sz = siz(2);
time_med = reshape(prctile(time_list, perc2, 1), [1 sz]);
time_low = reshape(prctile(time_list, perc1, 1), [1 sz]);
time_hi = reshape(prctile(time_list, perc3, 1), [1 sz]);

f = fill([ind_list flip(ind_list)], [time_low flip(time_hi)], cmap(1,:), 'linestyle', 'none');
set(f,'facealpha',0.2);
hold on;
plot(ind_list, time_med, 'color', cmap(1,:), 'marker', '.', 'markersize', 18, ...
    'linewidth', 2);
hold off;

elseif dim == 3

sz1 = siz(1); sz2 = siz(2); sz3 = siz(3);

for szi = 1:sz3
for szj = 1:sz2
if any( time_list(:,szj,szi) == 0 , 'all' )
    time_list(:,szj,szi) = zeros(sz1,1);
end 
end
end

time_med = reshape(prctile(time_list, perc2, 1), [sz2 sz3]);
time_low = reshape(prctile(time_list, perc1, 1), [sz2 sz3]);
time_hi = reshape(prctile(time_list, perc3, 1), [sz2 sz3]);

pl = [];
for szi = 1:sz3
f = fill([ind_list flip(ind_list)], [time_low(:,szi).' flip(time_hi(:,szi).')], cmap(szi,:), 'linestyle', 'none');
set(f,'facealpha',0.2);
hold on;
p = plot(ind_list, time_med(:,szi).', 'color', cmap(szi,:), 'marker', '.', 'markersize', 18, ...
    'linewidth', 2);
pl = [pl p];
hold on;
end
hold off;
legend(pl,legendcell,'fontsize',14);

end

xlabel('Loop Density', 'fontweight', 'bold', 'fontsize', 14);
ylabel('Total No. of Sweeps', 'fontweight', 'bold', 'fontsize', 14);
grid on;
grid minor;
if f_log
set(gca,'XScale','log','fontsize',12);
set(gca,'YScale','log','fontsize',12);
end

end
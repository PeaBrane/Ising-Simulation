function scaleplot(ind, SAlist, memlist, perc, f_log, labels, legendcell)

cmap = cbrewer('qual','Set2',8,'PCHIP');
colormap(cmap);

perc1 = perc(1); perc2 = perc(2); perc3 = perc(3);

SAmed = prctile(SAlist, perc2, 1);
SAlow = prctile(SAlist, perc1, 1);
SAhi = prctile(SAlist, perc3, 1);

memmed = prctile(memlist, perc2, 1);
memlow = prctile(memlist, perc1, 1);
memhi = prctile(memlist, perc3, 1);

pp = [];

f = fill([ind flip(ind)], [SAlow flip(SAhi)], cmap(1,:), 'linestyle', 'none');
set(f,'facealpha',0.4);
hold on;
[x,y] = poly_line(ind,SAmed);
p = plot(x, y, 'color', cmap(1,:), 'linewidth', 3);
pp = [pp p];
hold on;
scatter(ind, SAmed, 22, brighten(cmap(1,:),-0.5), 'filled');
hold on;

ind = ind(1:length(memmed));
f = fill([ind flip(ind)], [memlow flip(memhi)], cmap(2,:), 'linestyle', 'none');
set(f,'facealpha',0.4);
hold on;
[x,y] = poly_line(ind,memmed);
p = plot(x, y, 'color', cmap(2,:), 'linewidth', 3);
pp = [pp p];
hold on;
scatter(ind, memmed, 22, brighten(cmap(2,:),-0.5), 'filled');
hold on;

legend(pp,legendcell,'fontsize',14);

% xticks(ind);
title('3D Tiling Cubes', 'fontweight', 'bold', 'fontsize', 16);
xlabel(labels{1}, 'fontweight', 'bold', 'fontsize', 14);
ylabel(labels{2}, 'fontweight', 'bold', 'fontsize', 14);
grid on;
grid minor;
if f_log
set(gca,'XScale','log','fontsize',12);
set(gca,'YScale','log','fontsize',12);
end

end
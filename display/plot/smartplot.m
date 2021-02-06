function k = smartplot(iind, llist, perc, f_log, f_fit, tit, labels, legendcell, lims)

[iind,llist] = my_mat2cell(iind,llist); ll = length(iind);
k = cell(1,ll);
cmap = cbrewer('qual','Set2',length(iind),'PCHIP');
colormap(cmap);
if isempty(perc)
perc = [50 50 50];
end
if length(perc) == 3
perc1 = perc(1); perc2 = perc(2); perc3 = perc(3);
end

pl = [];
for ii = 1:ll
c = cmap(ii,:); ind = iind{ii}; list = llist{ii}; sz = size(list);
if sz(1) == 1
low = list; med = list; hi = list;
elseif length(perc) == 3
low = prctile(list,perc1,1); med = prctile(list,perc2,1); hi = prctile(list,perc3,1);   
elseif perc == 'm'
med = mean(list,1); low = med; hi = med;
elseif perc == 's'
med = mean(list,1); sigma = std(list,0,1);
low = med-sigma; hi = med+sigma;
end
lin = [];
if ~isempty(f_fit)
    [x,y,k{ii}] = poly_line(ind,med,f_fit(ii,:)); lin = [x;y];
end
p = myplot(ind,[low;med;hi],c,lin,1); pl = [pl p];  
end

hold on;
if ~isempty(legendcell)
legend(pl,legendcell,'fontsize',14,'interpreter','latex','location','northwest','autoupdate','off');
end
set(gca,'fontsize',12);
if ~isempty(tit)
title(tit, 'fontsize', 16, 'interpreter', 'latex');
end
if ~isempty(labels)
xlabel(labels{1}, 'fontsize', 16, 'interpreter', 'latex');
ylabel(labels{2}, 'fontsize', 16, 'interpreter', 'latex');
end
grid off;
% grid on;
% grid minor;
if f_log(1)
set(gca,'XScale','log');
end
if f_log(2)
set(gca,'YScale','log');
end

if ~isempty(lims)
xlim([lims(1) lims(2)]);
ylim([lims(3) lims(4)]);
end

end
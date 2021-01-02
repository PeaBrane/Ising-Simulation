function k = smartplot(iind, llist, perc, f_log, f_fit, tit, labels, legendcell)

[iind,llist] = my_mat2cell(iind,llist); ll = length(iind);
cmap = cbrewer('qual','Set2',length(iind),'PCHIP');
colormap(cmap);
perc1 = perc(1); perc2 = perc(2); perc3 = perc(3);

pl = [];
for ii = 1:ll
c = cmap(ii,:); ind = iind{ii}; list = llist{ii}; sz = size(list);
if sz(1) == 1
low = list; med = list; hi = list;
else
low = prctile(list,perc1,1); med = prctile(list,perc2,1); hi = prctile(list,perc3,1);   
end
lin = [];
if f_fit
    [x,y,k] = poly_line(ind,med,[1 10]); k = k(1); lin = [x;y];
end
p = myplot(ind,[low;med;hi],c,lin,1); pl = [pl p];  
end

hold off;
if ~isempty(legendcell)
legend(pl,legendcell,'fontsize',14,'interpreter','latex','location','northeast');
end
set(gca,'fontsize',12);
if ~isempty(tit)
title(tit, 'fontsize', 20, 'interpreter', 'latex');
end
if ~isempty(labels)
xlabel(labels{1}, 'fontsize', 16, 'interpreter', 'latex');
ylabel(labels{2}, 'fontsize', 16, 'interpreter', 'latex');
end
grid on;
grid minor;
if f_log(1)
set(gca,'XScale','log');
end
if f_log(2)
set(gca,'YScale','log');
end

end
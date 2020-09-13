function myplot(ind_list, time_list, perc, f_log, f_fit, tit, labels, legendcell)

cmap = cbrewer('qual','Set2',8,'PCHIP');
colormap(cmap);

siz = size(time_list);
dim = length(siz);
if dim == 2 && find(siz == 1)
    dim = 1;
end

if dim > 1
perc1 = perc(1); perc2 = perc(2); perc3 = perc(3);
end
if dim > 3
fprintf('Cannot Plot');
return;
end

if dim == 1

c = cmap(1,:);
plot(ind_list,time_list,'color',c,'marker','.','markersize',18,'linewidth',2);
    
elseif dim == 2

c = cmap(1,:);
sz = siz(2);
time_med = reshape(prctile(time_list, perc2, 1), [1 sz]);
time_low = reshape(prctile(time_list, perc1, 1), [1 sz]);
time_hi = reshape(prctile(time_list, perc3, 1), [1 sz]);

if ~f_fit
f = fill([ind_list flip(ind_list)], [time_low flip(time_hi)], c, 'linestyle', 'none');
set(f,'facealpha',0.4);
hold on;
plot(ind_list, time_med, 'color', c, 'marker', '.', 'markersize', 18, 'linewidth', 2);
hold off;
else
f = fill([ind_list flip(ind_list)], [time_low flip(time_hi)], c, 'linestyle', 'none');
set(f,'facealpha',0.4);
hold on;
scatter(ind_list, time_med, 18, c, 'filled');
hold on;
[x1,x2,y1,y2,a,b] = poly_line(ind_list,time_med,5);
txt1 = strcat('power= ',num2str(round(a(1),3))); txt2 = strcat('power= ',num2str(round(b(1),3)));
text(ind_list(end-5), time_med(end-5)/2^6, strcat(txt1,'  ',txt2), 'color',c,'fontsize',14,'fontweight','bold');
hold on;
p = plot(x1, y1, 'color', c, 'linewidth', 2);
plot(x2, y2, 'color', c, 'linewidth', 2);
hold off;  
end

elseif dim == 3

sz1 = siz(1); sz2 = siz(2); sz3 = siz(3);

for szi = 1:sz3
for szj = 1:sz2
if any( time_list(:,szj,szi) == 0 , 'all' )
    time_list(:,szj,szi) = zeros(sz1,1);
end 
end
end

time_low = reshape(prctile(time_list, perc1, 1), [sz2 sz3]);
time_med = reshape(prctile(time_list, perc2, 1), [sz2 sz3]);
time_hi = reshape(prctile(time_list, perc3, 1), [sz2 sz3]);

pl = [];
for szi = 1:sz3
    
c = cmap(szi,:);
tlow = time_low(:,szi).'; tmed = time_med(:,szi).'; thi = time_hi(:,szi).';
    
    if ~f_fit
    f = fill([ind_list flip(ind_list)], [tlow flip(thi)], c, 'linestyle', 'none');
    set(f,'facealpha',0.4);
    hold on;
    p = plot(ind_list, tmed, 'color', brighten(c,-0.3), 'marker', '.', 'markersize', 18, ...
        'linewidth', 2.5);
    hold on;
    else
    f = fill([ind_list flip(ind_list)], [time_low(:,szi).' flip(time_hi(:,szi).')], c, 'linestyle', 'none');
    set(f,'facealpha',0.4);
    hold on;
    scatter(ind_list, time_med(:,szi).', 18, brighten(c,-0.3),'filled');
    hold on;
    [x1,x2,y1,y2,a,b] = poly_line(ind_list,time_med(:,szi).',5);
    txt1 = strcat('power= ',num2str(round(a(1),3))); txt2 = strcat('power= ',num2str(round(b(1),3)));
    text(ind_list(end-5), time_med(end-5,szi)/2^(6+3*(szi-1)), strcat(txt1,'  ',txt2), 'color',brighten(c,-0.3),'fontsize',14,'fontweight','bold');
    hold on;
    p = plot(x1, y1, 'color', brighten(c,-0.3), 'linewidth', 2);
    plot(x2, y2, 'color', brighten(c,-0.3), 'linewidth', 2);
    hold on;   
    end
    pl = [pl p];

end

if ~isempty(legendcell)
legend(pl,legendcell,'fontsize',14,'interpreter','latex','location','northwest');
end

end

if ~isempty(tit)
title(tit, 'fontsize', 20);
end
if ~isempty(labels)
xl = xlabel(labels{1}, 'interpreter', 'latex');
yl = ylabel(labels{2}, 'interpreter', 'latex');
set(xl,'fontsize',24);
set(yl,'fontsize',24);
end

% xlim([min(ind_list) max(ind_list)]);
% ylim([min(time_low(:)) max(time_hi(:))]);
% xticks([1:10]);
% yticks([5:5:40]);
grid on;
grid minor;
% legend boxoff;

set(gca,'fontsize',12);
if f_log(1)
set(gca,'XScale','log');
end
if f_log(2)
set(gca,'YScale','log');
end

end
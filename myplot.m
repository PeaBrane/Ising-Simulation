function myplot(ind_list, time_list, perc, f_log)

siz = size(time_list);
dim = length(siz);

if dim > 3
    fprintf('Cannot Plot');
end

if dim == 2
    
time_est = prctile(time_list, perc, 2);
plot(ind_list, time_est);

elseif dim == 3

sz1 = siz(1);
time_est = prctile(time_list, perc, 3);
for szi = 1:sz1
plot(ind_list, time_est(szi,:));
hold on;
end

end

if f_log
set(gca,'XScale','log');
end

end
function myplot(ind_list, time_list, perc, f_log)

siz = size(time_list);
dim = length(siz);

if dim > 3
    fprintf('Cannot Plot');
end

if dim == 2
    
time_est = prctile(time_list, perc, 1);
plot(ind_list, time_est);

elseif dim == 3

sz1 = siz(1); sz2 = siz(2); sz3 = siz(3);
time_est = reshape(prctile(time_list, perc, 1), [sz2 sz3]);
for szi = 1:sz3
plot(ind_list, time_est(:,szi).');
hold on;
end

end

if f_log
set(gca,'XScale','log');
end

end
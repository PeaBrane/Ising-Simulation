clear;

n_list = [30];
n_length = length(n_list);

sz_list = [0.5:0.1:0.7];
sz_length = length(sz_list);

density_list = 0.1*1.12.^[40:2:50];
density_length = length(density_list);

time_list = zeros(n_length,sz_length,density_length);

for n_iter = 1:n_length
for sz_iter = 1:sz_length
for density_iter = 1:density_length
    
   n = n_list(n_iter); sz = sz_list(sz_iter); density = density_list(density_iter);
   fn = strcat(num2str(n),'-',num2str(sz),'-',num2str(density),'.mat');
   p = load(fn);
   p = p.variable;
   time_list(n_iter,sz_iter,density_iter) = prctile(p,50);
    
end
end
end

for sz_iter = 1:sz_length
   
    plot(density_list, reshape(time_list(1,sz_iter,:), [1 density_length 1]));
    hold on;
    
end
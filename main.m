clear all;
rng(0);

scale = 100; 
frus = 0.22;
loop_ratio = Inf; 
vers = 0; 
dev = 0;

runs = 40; 

n_list = [40];
n_length = length(n_list);

density_list = 0.1*1.12.^[60:2:62];
density_length = length(density_list);

sz_list = [0.7];
sz_length = length(sz_list);

tot_length = n_length*sz_length*density_length*runs;

time_list = zeros(sz_length, density_length, runs);

%%%%% Run %%%%%

for tot_iter = 1:tot_length 

[run,density_iter,sz_iter,n_iter] = ind2sub([runs,density_length,sz_length,n_length], tot_iter);
    
n = n_list(n_iter);
m = n_list(n_iter);
sz = sz_list(sz_iter);
density = density_list(density_iter);
n_loops = ceil(density*n);
beta = [0.01 log(n)]/scale;

[w,~,~,E] = gen_abW(n,m,scale,n_loops,loop_ratio,vers,frus,sz);
a = zeros(1,n); b = zeros(1,m);

n_monte = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);

time_list(sz_iter, density_iter, run) = get_time_gibbs(n,m,a,b,w,n_monte,beta,E,1000000000,dev);

% index = (quo-1)*runs+1:quo*runs;
% list = time_list(index);
% parsave(strcat('Gibbs-',num2str(n),'-',num2str(density),'-',num2str(vers),'.mat'),list);

fprintf('.');
if mod(tot_iter,runs) == 0
    fprintf('\n');
end

end

time50 = prctile(time_list, 50, 3);
for sz_iter = 1:sz_length
plot(density_list, time50(sz_iter,:));
hold on;
end
set(gca,'XScale','log');

%%%%% Save %%%%%
% 
% time95 = zeros(n_length,density_length);
% for n_iter = 1:n_length
%     for density_iter = 1:density_length
%         n = n_list(n_iter); density = density_list(density_iter);
%         quo = (n_iter-1)*density_length + density_iter;
%         index = (quo-1)*runs+1:quo*runs;
%         list = time_list(index);
%         parsave(strcat('Gibbs-',num2str(n),'-',num2str(density),'-struc','.mat'),list);
%         list = log(list); list_mean = mean(list); list_std = std(list);
%         time95(n_iter,density_iter) = exp(list_mean + 2*list_std);
%     end
% end

%%%%% Plot %%%%%

% figure(2)
% n_iter = 1;
% plot(density_list,time95(n_iter,:))
% set(gca,'XScale','log');
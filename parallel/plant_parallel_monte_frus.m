clear all;
rng(0);

scale = 1;
loop_ratio = 1; 
vers = 0; 
dev = 0;

frus_list = [0.05:0.025:0.2 0.21:0.01:0.24];
frus_length = length(frus_list);

n_lists = [100 100 400;
           100 100 400;
           100 100 400;
           100 100 400;
           100 100 400;
           100 100 400;
           100 100 200;
           40 10 100;
           30 10 80;
           20 5 60;
           10 5 40];

runs_lists = [10000 1000;
              10000 1000;
              10000 1000;
              10000 1000;
              10000 1000;
              10000 1000;
              10000 1000; 
              10000 100;
              10000 100;
              10000 100;
              10000 100];

tot_iter = 0;
for frus_iter = 1:frus_length
    frus = frus_list(frus_iter);
    N_list = n_lists(frus_iter,:);
    n_list = [N_list(1):N_list(2):N_list(3)];
    n_length = length(n_list);
    Runs_list = runs_lists(frus_iter,:);
    k = (Runs_list(2)/Runs_list(1))^(1/(N_list(3)-N_list(1)));
    runs_list = ceil(Runs_list(1)*k.^(n_list - N_list(1)));
    for n_iter = 1:n_length
        n = n_list(n_iter);
        runs = runs_list(n_iter);
        tot_iter = tot_iter + 1;
        index_list(tot_iter,:) = [frus,n,runs];
    end
end
        
lengths = index_list(:,3).'; l = length(lengths); sums = lengths;
for i = 1:l
    if i == 1
        sums(i) = lengths(i);
    else
        sums(i) = sum(lengths(1:i));
    end
end

% tot_length = sum(lengths);
tot_length = length(lengths);
time_list = zeros(1,tot_length);

parfor tot_iter = 1:tot_length 

% index = 0; ti = tot_iter;
% while ti > 0.1
%     ti = ti - lengths(index+1);
%     index = index + 1;
% end
index = tot_iter;

frus = index_list(index,1);
n = index_list(index,2);
m = index_list(index,2);

density = 0.3035 + 0.2952*exp(-0.0196*n);

beta = [0.01 log(n)];
n_loops = ceil(density*(n+1));


monte = ceil((1.29*n^2 - 33.1*n + 1664)*...
          (41.4*frus^3 - 11.7*frus^2 + 1.06*frus - 0.018));
      
runs = index_list(index,3);

list = zeros(1,runs);
for run = 1:runs
[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);
list(run) = get_time_gibbs(n,m,a,b,w,monte,beta,E,100000000,dev,n_loops);
end

parsave(strcat('Gibbs-',num2str(frus),'-',num2str(n),'.mat'),list);

end

% index = 0;
% for frus_iter = 1:frus_length
% frus = frus_list(frus_iter);
%     
% N_list = n_lists(frus_iter,:);
% n_list = [N_list(1):N_list(2):N_list(3)];
% n_length = length(n_list);
% 
% for n_iter = 1:n_length
% n = n_list(n_iter);
%     
% index = index + 1;
% if index == 1
%     index_range = 1:sums(1);
% else
%     index_range = sums(index-1)+1:sums(index);
% end
% 
% list = time_list(index_range);
% 
% parsave(strcat('Gibbs-',num2str(frus),'-',num2str(n),'.mat'),list);
% 
% end
% 
% end
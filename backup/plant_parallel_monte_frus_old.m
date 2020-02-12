clear all;
rng(0);

scale = 1;
loop_ratio = 1; 
vers = 0; 
dev = 0;
density = 0.47;

frus_list = [0.05:0.025:0.175 0.22:0.01:0.23];
frus_length = length(frus_list);

n_lists = [10 10 90;
           10 10 90;
           10 10 90;
           10 10 90;
           10 10 90;
           10 10 90;
           20 10 80;
           15 5 50];
       
runs_lists = [100000 10000;
              100000 10000;
              100000 10000;
              100000 10000;
              100000 10000;
              100000 10000;
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

beta = [0.01 log(n)];
n_loops = ceil(density*(n+1));

monte = ceil((0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102));

% [a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);
% time_list(tot_iter) = get_time_gibbs(n,m,a,b,w,monte,beta,E,100000000,dev,n_loops);

runs = index_list(index,3);
list = zeros(1,runs);
for run = 1:runs
    [a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);
    list(run) = get_time_gibbs(n,m,a,b,w,monte,beta,E,100000000,dev,n_loops);
end
parsave(strcat('Gibbs-',num2str(frus),'-',num2str(n),'-old.mat'),list);

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
% parsave(strcat('Gibbs-',num2str(frus),'-',num2str(n),'-old.mat'),list);
% 
% end
% 
% end
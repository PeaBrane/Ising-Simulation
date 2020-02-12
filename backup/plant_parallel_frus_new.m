clear all;
rng(0);

scale = 1;
loop_ratio = 1; 
vers = 0; 
dev = 0;

frus_list = [0.05:0.025:0.15];
frus_length = length(frus_list);

n_lists = [40 10 80;
           50 10 80;
           50 10 80;
           50 10 80;
           70 10 80];

runs_lists = 10*ones(19,2);
         
monte_lists = [5 1 20; 10 1 30; 10 2 60; 50 5 150; 50 5 150;
               10 1 30; 10 2 60; 50 5 150; 50 5 150;
               10 1 40; 10 2 50; 50 5 150; 50 5 150;
               10 2 50; 20 2 60; 50 5 150; 50 5 150;
               50 5 150; 50 5 150];

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
        Monte_list = monte_lists(tot_iter,:);
        monte_list = [Monte_list(1):Monte_list(2):Monte_list(3)];
        monte_length = length(monte_list);
        monte_lengths(tot_iter) = monte_length;
        index_list(tot_iter,:) = [frus,n,runs,monte_length];
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

tot_length = sum(lengths);
time_list = zeros(tot_length,max(monte_lengths));

for tot_iter = 1:tot_length 

index = 0; ti = tot_iter;
while ti > 0.1
    ti = ti - lengths(index+1);
    index = index + 1;
end

frus = index_list(index,1);
n = index_list(index,2);
m = index_list(index,2);

density = 0.3424 + 0.3937*exp(-0.0361*n);

beta = [0.01 log(n)];
n_loops = ceil(density*(n+1));

[a,b,w,v,h,E] = gen_abW(n,m,n_loops,loop_ratio,vers,frus);

Monte_list = monte_lists(index,:);
monte_list = [Monte_list(1):Monte_list(2):Monte_list(3)];
monte_length = length(monte_list);

dummy = zeros(1,max(monte_lengths));
for monte_iter = 1:max(monte_lengths)
if monte_iter <= monte_length
monte = monte_list(monte_iter);
dummy(monte_iter) = get_time_gibbs(n,m,a,b,w,monte,beta,E,10000000,dev,n_loops);
else
dummy(monte_iter) = 0;
end
end
time_list(tot_iter,:) = time_list(tot_iter,:) + dummy;

if mod(tot_iter,10000) == 0
    fprintf(strcat('frus=',num2str(frus),' n=',num2str(n),' monte=',num2str(monte)));
    fprintf('\n');
end

end

index = 0;
for frus_iter = 1:frus_length
frus = frus_list(frus_iter);
    
N_list = n_lists(frus_iter,:);
n_list = [N_list(1):N_list(2):N_list(3)];
n_length = length(n_list);

for n_iter = 1:n_length
n = n_list(n_iter);
    
index = index + 1;
if index == 1
    index_range = 1:sums(1);
else
    index_range = sums(index-1)+1:sums(index);
end

Monte_list = monte_lists(index,:);
monte_list = [Monte_list(1):Monte_list(2):Monte_list(3)];
monte_length = length(monte_list);

for monte_iter = 1:monte_length
monte = monte_list(monte_iter);
list = time_list(index_range, monte_iter).';
parsave(strcat('Gibbs-',num2str(frus),'-',num2str(n),'-',num2str(monte),'.mat'),list);
end

end

end
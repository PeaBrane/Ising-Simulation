function timelist = get_timelist(runs,wlist,Elist,n_monte,beta,cap,perc,dev)
% returns the TTSs of a particular class of instances,
% assuming that only a certain percentile is required

n = size(wlist,1); m = size(wlist,2);
a = zeros(1,n); b = zeros(1,m);
timelist = zeros(1,runs);

counter = 0;
unsolve = 1:runs;

% solves the instances continually
% until a certain percentage of instances are solved
while true
list = zeros(1,runs);
for run = unsolve
w = wlist(:,:,run); E = Elist(run);
time = SA_time(n,m,a,b,w,n_monte,beta,E,10^cap,dev);
if time <= 10^cap
    counter = counter+1;
    unsolve(find(unsolve == run)) = [];
end
list(run) = time;
end
timelist = timelist + list;

% terminates when a certain percentage of instances are solved
if counter > ceil(runs*perc/100)+1
    break;
end
end

% sets the TTSs of the unsolved instances to Inf
timelist(unsolve) = Inf;

end


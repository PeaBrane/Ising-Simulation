function mat = noise(sz,list,cov)

if min(list) <= 0
    mat = 0;
    return
end

d = length(sz);
per = [1 d+1 3:d 2];
counters = length(list);
temp = sqrt(repmat(sqrt(permute(list,per)),[sz 1]));

if isempty(cov)

mat = normrnd(0,temp,[sz counters]);

else

mat = temp.*reshape(mvnrnd(zeros(1,prod(sz)),cov,counters).',[sz counters]);
    
end

end
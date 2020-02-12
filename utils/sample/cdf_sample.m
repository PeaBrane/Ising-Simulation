function x = cdf_sample(cdf)

x = rand();
cdf = [cdf x];
cdf = sort(cdf,'ascend');
x = find(cdf == x);

end
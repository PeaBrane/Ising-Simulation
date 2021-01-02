function x = cdf_sample(cdf)

x = rand('single');
cdf = [cdf x];
cdf = sort(cdf,'ascend');
x = find(cdf == x,1,'first');

end
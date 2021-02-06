function [list,b,bg,cn] = get_sclus(v)

uf = 'uniformoutput';
sz = size(v); d = length(sz); N = prod(sz); 
flag = 0; cn = zeros([1 N]);
if ~any(v)
    list = []; b = 0; bg = [];
    return; 
end

if d == 2
pixels = bwconncomp(v,4);
elseif d == 3
pixels = bwconncomp(v,6);
end

idx = cellfun(@int16,pixels.PixelIdxList,uf,0);
if isempty(idx)
    list = []; b = 0; bg = [];
    return;
end
idx = cellfun(@transpose,periodic(cellfun(@transpose,idx,uf,false),sz),uf,0);

for ii = 1:1:length(idx)
if any(find(idx{ii} == 1))
flag = 1;
break;
end
end
if flag
cn(idx{ii}) = 1;
end

bsz = cellfun(@length,idx);
[b,bg] = my_gp(bsz.');
ind = cdf_sample(to_cdf(bsz));
list = idx{ind};

end
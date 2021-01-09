function idx = intersect_diff(idx,b,sz)

ll = length(idx); bdx = cell(1,ll);
for ii = 1:ll
bdx{ii} = my_intersect(idx{ii},b);
end
nz = find(~cellfun(@isempty,bdx));
if isempty(nz)
    return;
end

if length(sz) > 1
    nn1 = prod(sz(1:end-1));
    nn2 = (sz(end)-1)*nn1;
else
    nn1 = 1; nn2 = sz(1)-1;
end

for i = length(nz):-1:1
for j = i-1:-1:1
ii = nz(i); jj = nz(j);
list1 = bdx{ii}; list2 = bdx{jj};
mat = repmat(list1.',[1 length(list2)]) - repmat(list2,[length(list1) 1]);
mat = mod(mat,prod(sz));
if any(mat==nn1,'all') || any(mat==nn2,'all')
idx{jj} = [idx{jj} my_setdiff(idx{ii},idx{jj})];
idx(ii) = [];
break;
end
end
end

end
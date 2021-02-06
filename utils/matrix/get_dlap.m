function dlap = get_dlap(v0,vlist,rlist,falgo)

fICM = falgo(2);

if ~fICM

nr = size(rlist,2);
dlap = zeros(1,nr); N = numel(v0{1,1});
for r = 1:nr
ir = rlist(r);
dlap(ir) = double(sum( v0{ir}.*vlist{r} ,'all'))/N;
end

else
    
nc = size(rlist,1); nr = size(rlist,2);
dlap = zeros(nc,nr); N = numel(v0{1,1});
for c = 1:nc
for r = 1:nr
ir = rlist(c,r);
dlap(c,ir) = double(sum(v0{c,ir}.*vlist{c,r},'all'))/N;
end
end

end

end
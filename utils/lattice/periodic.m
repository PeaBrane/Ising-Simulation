function idx = periodic(idx,sz)

d = length(sz); 
if d == 2
    idx = periodic_2d(idx,sz);
elseif d == 3
    idx = periodic_3d(idx,sz); 
end

end
function sub = myind2sub(sz, ind)

sub = [];
dim = length(sz);
quo = ind;
for d = 1:dim
    rem = mod(quo-1,sz(d))+1;
    quo = fix((quo-1)/sz(d))+1;
    sub = [sub rem];
end

end
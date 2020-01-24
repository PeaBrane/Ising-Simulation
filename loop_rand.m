function W = loop_rand(n,m,scale,frus,n_loops)

W = zeros(n,m);
Wneg = ones(n,m);
Wpos = ones(n,m);
alpha = floor(3*frus/(1-frus)*scale);

loop = 0;
while loop < n_loops
    
h0 = mysample(1:m);
vpos = find(Wpos(:,h0).'); vneg = find(Wneg(:,h0).');
if length(vpos) < 1 || length(vneg) < 1
    continue;
end
v0 = mysample(vneg);
vpos = setdiff(vpos,v0);
if length(vpos) < 1
    continue;
end
v1 = mysample(vpos);

hlist = [];
for j = setdiff(1:m,h0)
    if Wpos(v0,j) && Wpos(v1,j) 
        hlist = [hlist j];
    end
end

if isempty(hlist)
    continue;
else
    h1 = mysample(hlist);
end

W(v0,h0) = W(v0,h0) - alpha; Wpos(v0,h0) = 0;
W(v0,h1) = W(v0,h1) + scale; Wneg(v0,h1) = 0;
W(v1,h0) = W(v1,h0) + scale; Wneg(v1,h0) = 0;
W(v1,h1) = W(v1,h1) + scale; Wneg(v1,h1) = 0;

loop = loop + 1;
    
end

end
function W = loop_struc(n,m,scale,frus,nl1,nl2,nl3,sz)

n1 = ceil(n*sz); m1 = ceil(m*sz);
W = zeros(n,m);
Wpos = ones(n1,m1);
Wneg = ones(n1,m1);

alpha = floor(3*frus/(1-frus)*scale);

loop = 0;
while loop < nl1
   
h0 = mysample(1:m1);
vneg = find(Wneg(:,h0).');
v0 = mysample(vneg);
if v0 == 0
    continue;
end
vpos = setdiff(find(Wpos(:,h0).'),v0);
v1 = mysample(vpos);
if v1 == 0
    continue;
end
    
h1 = mysample(m1+1:m);

W(v0,h0) = W(v0,h0) - alpha; Wpos(v0,h0) = 0;
W(v0,h1) = W(v0,h1) + scale; 
W(v1,h0) = W(v1,h0) + scale; Wneg(v1,h0) = 0;
W(v1,h1) = W(v1,h1) + scale; 

loop = loop + 1;
end

loop = 0;
while loop < nl2
    
v0 = mysample(1:n1);
hneg = find(Wneg(v0,:));
h0 = mysample(hneg);
if h0 == 0
    continue;
end
hpos = setdiff(find(Wpos(v0,:)),h0);
h1 = mysample(hpos);
if h1 == 0
    continue;
end
    
v1 = mysample(n1+1:n);

W(v0,h0) = W(v0,h0) - alpha; Wpos(v0,h0) = 0;
W(v0,h1) = W(v0,h1) + scale; Wneg(v0,h1) = 0;
W(v1,h0) = W(v1,h0) + scale; 
W(v1,h1) = W(v1,h1) + scale; 

loop = loop + 1;
end

loop = 0;
while loop < nl3
    
h0 = mysample(1:m1);
vneg = find(Wneg(:,h0).');
v0 = mysample(vneg);
if v0 == 0
    continue;
end

v1 = mysample(n1+1:n);
h1 = mysample(m1+1:m);

W(v0,h0) = W(v0,h0) - alpha; Wpos(v0,h0) = 0;
W(v0,h1) = W(v0,h1) + scale;
W(v1,h0) = W(v1,h0) + scale; 
W(v1,h1) = W(v1,h1) + scale; 

loop = loop + 1;
end

end
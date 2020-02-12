function W = loop_struc(n,m,scale,frus,nl1,nl2,nl3,sz)
% structured loop algorithm

% nl1 is the number of left loops
% nl2 is the number of upper loops
% nl3 is the number of center loops
% sz parameterizes the size of the upper-left block

n1 = ceil(n*sz); m1 = ceil(m*sz);
W = zeros(n,m); % empty RBM weight matrix
Wneg = ones(n1,m1); % records the indices of non-positive elements
Wpos = ones(n1,m1); % records the indices of non-negative elements

% break the degeneracy slightly if frus = 0.25
if frus == 0.25
    alpha = scale - 1;
else
    alpha = floor(3*frus/(1-frus)*scale);
end

% cflag is set true if there are only center loops,
% which allows for a faster generation of W
if nl1 == 0 && nl2 == 0
    cflag = 1;
else
    cflag = 0;
end

% superposing left loops
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

% superposing upper loops
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

% superposing center loops
loop = 0;
while loop < nl3

h0 = ceil(rand()*m1);

if ~cflag    
vneg = find(Wneg(:,h0).');
v0 = mysample(vneg);
if v0 == 0
    continue;
end
else
v0 = ceil(rand()*n1);   
end

v1 = n1 + ceil(rand()*(n-n1));
h1 = m1 + ceil(rand()*(m-m1));

W(v0,h0) = W(v0,h0) - alpha;
W(v0,h1) = W(v0,h1) + scale;
W(v1,h0) = W(v1,h0) + scale; 
W(v1,h1) = W(v1,h1) + scale; 

loop = loop + 1;
end

end
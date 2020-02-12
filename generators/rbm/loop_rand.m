function W = loop_rand(n,m,scale,frus,n_loops)
% random loop algorithm

W = zeros(n,m); % empty RBM weight matrix
Wneg = ones(n,m); % records the indices of non-positive elements
Wpos = ones(n,m); % records the indices of non-negative elements

% break the degeneracy slightly if frus = 0.25
if frus == 0.25
    alpha = scale - 1;
else
    alpha = floor(3*frus/(1-frus)*scale);
end

loop = 0;
while loop < n_loops

% get a random column
h0 = ceil(rand()*m);

% get a random non-positive element indexed (v0,h0) and
% a random non-negative element indexed (v1,h0)
vpos = find(Wpos(:,h0).'); vneg = find(Wneg(:,h0).');
if isempty(vpos) || isempty(vneg)
    continue;
end
v0 = mysample(vneg);
vpos(find(vpos == v0)) = [];
if isempty(vpos)
    continue;
end
v1 = mysample(vpos);

% get a random column h1 distinct from h0 such that
% elements (v0,h1) and (v1,h1) are non-negative
hlist = find(Wpos(v0,:) & Wpos(v1,:));
if isempty(hlist) || all(hlist == h0)
    continue;
else
    hlist(find(hlist == h0)) = [];
end
h1 = mysample(hlist);

% superpose the frustrated loop onto the weight matrix W
W(v0,h0) = W(v0,h0) - alpha; Wpos(v0,h0) = 0;
W(v0,h1) = W(v0,h1) + scale; Wneg(v0,h1) = 0;
W(v1,h0) = W(v1,h0) + scale; Wneg(v1,h0) = 0;
W(v1,h1) = W(v1,h1) + scale; Wneg(v1,h1) = 0;

loop = loop + 1;
    
end

end
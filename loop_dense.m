function W = loop_dense(n,m,frus,n_loops)

alpha = floor(3*frus/(1-frus)*scale);
[negs,indices] = bone(n,m);
W = zeros(n,m);

L = sum(cellfun(@length, indices));
p = 1/L*ones(1,L);
Loops = mnrnd(n_loops, p);

counter = 0;
for c = negs
index = indices{c}.';
if isempty(index)
    continue;
end
for d = indices{c}.'
    
    counter = counter + 1;
    loop = Loops(counter);
    
    [i1,j1] = ind2sub([n,m],c);
    [i2,j2] = ind2sub([n,m],d);
    
    W(i1,j1) = W(i1,j1) - alpha*loop;
    W(i1,j2) = W(i1,j2) + scale*loop;
    W(i2,j1) = W(i2,j1) + scale*loop;
    W(i2,j2) = W(i2,j2) + scale*loop;

end
end

end
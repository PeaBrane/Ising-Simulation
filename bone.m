function [negs, indices] = bone(n,m)

W = rand(n,m);
W(W > 0.7) = 1;
W(W <= 0.7) = 0;
negs = find(W).';
indices = cell(1, n*m);

for c = negs
        
        if W(c) == 0
            continue;
        end
        
        [i,j] = ind2sub([n,m], c);
        
        vneg = find(W(:,j).');
        hneg = find(W(i,:));
        W1 = W;
        W1(vneg, :) = 1;
        W1(:, hneg) = 1;
        indices{c} = find(W1 == 0);
        
end

end
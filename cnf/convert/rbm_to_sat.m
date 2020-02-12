function [c1,c2,w1,w2,wmax,nclause] = rbm_to_sat(n,m,a,b,W)
% converts an RBM instance to a weighted Max-2-SAT instance

l1 = length(find(a)) + length(find(b));
c1 = zeros(l1, 1);
w1 = zeros(l1, 1);

% from visible biases to 1-SAT clauses
for i = 1:n
    if a(i) > 0
        c1(i) = i;
        w1(i) = a(i);
    elseif a(i) < 0
        c1(i) = -i;
        w1(i) = -a(i);
    else
        continue;
    end
end

% from hidden biases to 1-SAT clauses
for j = 1:m
    if b(j) > 0
        c1(n+j) = n+j;
        w1(n+j) = b(j);
    elseif b(j) < 0
        c1(n+j) = -(n+j);
        w1(n+j) = -b(j);
    else
        continue;
    end
end

l2 = length(find(W));
c2 = zeros(2*l2, 2);
w2 = zeros(2*l2, 1);

% from weights to 2-SAT clauses
k = 0;
for i = 1:n
    for j = 1:m
        
        k = k+1;
        k1 = 2*k-1; k2 = 2*k;
        
        if W(i,j) > 0
            c2(k1, 1) = i;
            c2(k1, 2) = -(n+j);
            c2(k2, 1) = -i;
            c2(k2, 2) = n+j;
            w2(k1) = W(i,j);
            w2(k2) = W(i,j);
        elseif W(i,j) < 0 
            c2(k1, 1) = i;
            c2(k1, 2) = n+j;
            c2(k2, 1) = -i;
            c2(k2, 2) = -(n+j);
            w2(k1) = -W(i,j);
            w2(k2) = -W(i,j);
        else
            k = k-1;
        end
        
    end
end

w1 = w1.'; w2 = w2.';
wmax = max([w1 w2]); nclause = length([w1 w2]);

end
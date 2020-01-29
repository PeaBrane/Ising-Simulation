function [w,E,cost] = generate(n,m,scale,n_loops,loop_ratio,vers,frus,sz)

nl1 = ceil(n_loops/(2+loop_ratio));
nl2 = ceil(n_loops/(2+loop_ratio));
nl3 = ceil(n_loops*loop_ratio/(2+loop_ratio));

if loop_ratio == Inf
    nl1 = 0; nl2 = 0;
    nl3 = n_loops;
end

if vers == 0
    W = loop_rand(n,m,scale,frus,n_loops);
elseif vers == 1
    W = loop_struc(n,m,scale,frus,nl1,nl2,nl3,sz);
elseif vers == 2
    W = loop_dense(n,m,scale,frus,n_loops);
else
    fprintf('Version Error');
    return;
end

E = sum(W(:));
% [v,h,w] = gauge(n,m,W);
w = W;
cost = (sum(abs(W(:))) - E)/2;

end
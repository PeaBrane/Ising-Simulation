function [w,E,cost] = floops(n,m,k,density,ll0)

N = n*m*k;
nloops = ceil(N*density);
w = zeros(n,m,k,3);
E = 0;

for counter = 1:nloops
    
    [indices,dirs] = loop(n,m,k,ll0);
    ll = length(indices);
    E = E + ll - 2;
    
    f = ceil(rand()*ll);
    edge = 1;
    
    for i = 1:ll
        
        if i == f
            edge = -1;
        end
        
        index = indices(i);
        dir = dirs(i);
        [sub1,sub2,sub3] = ind2sub([n m k],index);
        
        if dir == 1
            sub11 = mymod(sub1-1,n);
            w(sub11,sub2,sub3,1) = w(sub11,sub2,sub3,1)+edge;
        elseif dir == 2
            w(sub1,sub2,sub3,1) = w(sub1,sub2,sub3,1)+edge;
        elseif dir == 3
            sub21 = mymod(sub2-1,m);
            w(sub1,sub21,sub3,2) = w(sub1,sub21,sub3,2)+edge;
        elseif dir == 4
            w(sub1,sub2,sub3,2) = w(sub1,sub2,sub3,2)+edge;
        elseif dir == 5
            sub31 = mymod(sub3-1,k);
            w(sub1,sub2,sub31,3) = w(sub1,sub2,sub31,3)+edge;
        elseif dir == 6
            w(sub1,sub2,sub3,3) = w(sub1,sub2,sub3,3)+edge;
        else
            fprintf("Error");
            return;
        end
           
        if edge == -1
            edge = 1;
        end
        
    end
    
end

cost = (sum(abs(w(:)))-E)/2;

end
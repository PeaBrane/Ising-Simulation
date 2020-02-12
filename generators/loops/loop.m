function [list,dirlist] = loop(n,m,k,ll)

list = zeros(1,ll);
dirlist = zeros(1,ll);

while true
    
    counter = 0;
    i = ceil(rand()*n); 
    j = ceil(rand()*m); 
    l = ceil(rand()*k);
    
    while true
        counter = counter+1;
        c = mysub2ind([n m k],i,j,l);
        list(counter) = c;
        dir = ceil(rand()*6);
        dirlist(counter) = dir;
        
        if dir == 1
            i = mymod(i-1,n);
        elseif dir == 2
            i = mymod(i+1,n);
        elseif dir == 3
            j = mymod(j-1,m);
        elseif dir == 4
            j = mymod(j+1,m);
        elseif dir == 5
            l = mymod(l-1,k);
        else
            l = mymod(l+1,k);
        end
        
        c = mysub2ind([n m k],i,j,l);
        b = find(list == c);
        if ~isempty(b)
            list = list(b:counter);
            dirlist = dirlist(b:counter);
            break;
        end
    end
    
    if length(list) < ll
        continue;
    else
        break;
    end
    
end

end
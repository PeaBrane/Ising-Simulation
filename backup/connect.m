function [labels,index_list] = connect(spins_list,Wp,beta)

n = size(Wp,1); m = size(Wp,2);
index_list = [];
labels = zeros(n,m);

for i = 1:n
i2 = mod(i,n)+1;
for j = 1:m
if mod(i+j,2) == 0
j2 = mod(j,m)+1;

    spins = [spins_list(i,j) spins_list(i,j2) spins_list(i2,j2) spins_list(i2,j)];
    W = [Wp(i,j,1) Wp(i,j,4) Wp(i,j,3) Wp(i,j,2)];  
    label = [labels(i,j) labels(i,j2) 0 0];

    bonds = zeros(1,4);
    for ii = 1:4
        ii2 = mod(ii,4)+1;
        bond = spins(ii)*spins(ii2)*W(ii);
        if bond > 0
        if floor(rand() + 1 - exp(-2*beta*bond))
            bonds(ii) = 1;
        end
        end
    end
    
    if bonds(1)
        if label(1) && label(2) && label(1) ~= label(2)
            index_list = index_list(index_list ~= label(2));
            labels(labels == label(2)) = label(1);
            label(2) = label(1); 
        elseif label(1) && ~label(2)
            label(2) = label(1);
        elseif label(2) && ~label(1)
            label(1) = label(2);
        elseif ~label(1) && ~label(2)
            if isempty(index_list)
                index = 1;
            else
                index = index_list(end)+1;
            end
            label(1) = index; label(2) = index;
            index_list = [index_list index];
        end
    end
    
    if bonds(2) 
        label(3) = label(2); 
    end
    if bonds(4) 
        label(4) = label(1); 
    end
    
    if bonds(3)
        if label(3) && label(4) && label(3) ~= label(4)
            index_list = index_list(index_list ~= label(3));
            labels(labels == label(3)) = label(4);
            label(3) = label(4); 
        elseif label(3) && ~label(4)
            label(4) = label(3);
        elseif label(4) && ~label(3)
            label(3) = label(4);
        elseif ~label(3) && ~label(4)
            if isempty(index_list)
                index = 1;
            else
                index = index_list(end)+1;
            end
            label(3) = index; label(4) = index;
            index_list = [index_list index];
        end
    end
    
    labels([i i2],[j j2]) = [label(1) label(2); label(4) label(3)];
    
end 
end
end

end
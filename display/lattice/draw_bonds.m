function draw_bonds(spins,w)

n = size(w,1); m = size(w,2); k = size(w,3);
cmap = zeros(n*m*k,3);
indices = get_indices(n,m,k,3);

for i = 1:n
for j = 1:m
for l = 1:k
        
        index = indices(i,j,l);
    
        if spins(i,j,l) > 0
            cmap(index,:) = [0 0 0];
        else
            cmap(index,:) = [1 0 0];
        end
        
        if w(i,j,l,1) > 0
            line([i i+1],[j j],[l l],'color','black','linewidth',2);
        elseif w(i,j,l,1) < 0
            line([i i+1],[j j],[l l],'color','red','linewidth',2);
        end
        if w(i,j,l,2) > 0
            line([i i],[j j+1],[l l],'color','black','linewidth',2);
        elseif w(i,j,l,2) < 0
            line([i i],[j j+1],[l l],'color','red','linewidth',2);
        end
        if w(i,j,l,3) > 0
            line([i i],[j j],[l l+1],'color','black','linewidth',2);
        elseif w(i,j,l,3) < 0
            line([i i],[j j],[l l+1],'color','red','linewidth',2);
        end
   
end        
end
end

view(3);

hold on;
x = reshape(repmat(1:n,[m*k 1]),[1 n*m*k]);
y = repmat(reshape(repmat(1:m,[k 1]),[1 m*k]),[1 n]);
z = repmat(1:k,[1 n*m]);
scatter3(x,y,z,25,cmap,'filled');
set(gca,'visible','off');

end
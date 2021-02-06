function draw_bonds(spins,w)

sz = size(w); l = sz(end); d = sz(end); sz = sz(1:end-1);
if l == 2*d
    w = get_ww(w);
end

if isempty(spins)
    spins = ones(sz);
end

if d == 2

n = size(w,1); m = size(w,2);
cmap = zeros(n*m,3);
indices = reshape(1:n*m,[n m]);

for i = 1:n
for j = 1:m
        
        index = indices(i,j);
    
        if spins(i,j) > 0
            cmap(index,:) = [0 0 0];
        else
            cmap(index,:) = [1 0 0];
        end
        
        if w(i,j,1) > 0
            line([i i+1],[j j],'color','black','linewidth',2);
        elseif w(i,j,1) < 0
            line([i i+1],[j j],'color','red','linewidth',2);
        end
        if w(i,j,2) > 0
            line([i i],[j j+1],'color','black','linewidth',2);
        elseif w(i,j,2) < 0
            line([i i],[j j+1],'color','red','linewidth',2);
        end
       
end
end

hold on;
x = reshape(repmat(1:n,[m 1]),[1 n*m]);
y = repmat(1:m,[1 n]);
scatter(x,y,25,cmap,'filled');
set(gca,'visible','off');
    
elseif d == 3    

n = size(w,1); m = size(w,2); k = size(w,3);
cmap = zeros(n*m*k,3);
indices = reshape(1:3*prod(sz),[n m k 3]);

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

end
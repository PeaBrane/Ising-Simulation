function draw_S(S)

newplot;

sz = size(S); n = sz(1); m = sz(2);

line([1 n+1], [1 1],'color','black','linewidth',1);
line([1 1], [1 m+1],'color','black','linewidth',1);
line([n+1 n+1], [1 m+1],'color','black','linewidth',1);
line([1 n+1], [m+1 m+1],'color','black','linewidth',1);

for i = 1:n
for j = 1:m
   
    s = reshape(S(i,j,:),[1 4]);
    
    if s(1) == -1
        line([i+0.5 i+0.5],[j j+0.5],'color','red','linewidth',2);
    end
    if s(2) == -1
        line([i i+0.5],[j+0.5 j+0.5],'color','red','linewidth',2);
    end
    if s(3) == -1
        line([i+0.5 i+0.5],[j+0.5 j+1],'color','red','linewidth',2);
    end
    if s(4) == -1
        line([i+0.5 i+1],[j+0.5 j+0.5],'color','red','linewidth',2);
    end
    
end
end

xlim([1 n+1]); ylim([1 m+1]);
set(gca,'visible','off');
view(2);

end
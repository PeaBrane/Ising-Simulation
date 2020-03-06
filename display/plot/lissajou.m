function lissajou(v1,v2)

v1 = reshape(v1,[1 numel(v1)]);
v2 = reshape(v2,[1 numel(v2)]);

cmap = cbrewer('qual','Set2',8,'PCHIP');
plot(v1,v2,'color',cmap(1,:));

end
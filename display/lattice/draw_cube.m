function draw_cube(cube)

linex = zeros(12,2);
liney = zeros(12,2);
linez = zeros(12,2);

for i = 1:12
    
    if i <= 8
        
        if i > 4
            linez(i,:) = [1 1];
        end
        
        if mod(i-1,4) == 0
            linex(i,:) = [0 1];
        elseif mod(i-1,4) == 1
            linex(i,:) = [1 1];
            liney(i,:) = [0 1];
        elseif mod(i-1,4) == 2
            linex(i,:) = [0 1];
            liney(i,:) = [1 1];
        else
            liney(i,:) = [0 1];
        end
        
    else
        
        linez(i,:) = [0 1];
        if i == 10
            linex(i,:) = [1 1];
        elseif i == 11
            linex(i,:) = [1 1];
            liney(i,:) = [1 1];
        elseif i == 12
            liney(i,:) = [1 1];
        end
        
    end
    
end

for i = 1:12
    if cube(i) > 0
        line(linex(i,:),liney(i,:),linez(i,:),'color','black','linewidth',2);
    else
        line(linex(i,:),liney(i,:),linez(i,:),'color','red','linewidth',2);
    end
end

view(3);

end
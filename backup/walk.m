function loop = walk(n, m, ll)

indices = [-2; -2];
count = 2;
while true
    x = ceil(rand()*n); y = ceil(rand()*m);
    X0 = indices(1,1:max(count-ll-1,1)); Y0 = indices(2,1:max(count-ll-1,1));
    X = indices(1,max(count-ll,1):count-1); Y = indices(2,max(count-ll,1):count-1);
    while ismember(x,X)  x = ceil(rand()*n);  end
    while ismember(y,Y)  y = ceil(rand()*m);  end
    indices = [indices [x;y]];
    if ismember(x,X0) || ismember(y,Y0)
        break;
    end
    count = count + 1;
end

X = indices(1,1:count-1); Y = indices(2,1:count-1);
if ismember(x,X)
    start = find(x==X);
    loop = [[X(start:count-1) x]; [Y(start:count-1) -1]];
elseif ismember(y,Y)
    start = find(y==Y);
    loop = [[-1 X(start+1:count-1) x]; Y(start:count-1) y];
end
    
end
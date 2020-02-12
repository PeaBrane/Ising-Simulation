function labels = periodic(n,m,k,pixels)

labels = zeros(n,m,k);

lp = length(pixels);
for p = 1:lp
    labels(pixels{p}) = p;
end

% face check

for i = 2:n-1
for j = 2:m-1
    if (labels(i,j,1) && labels(i,j,k)) && (labels(i,j,1) ~= labels(i,j,k))
        labels(labels == labels(i,j,1)) = labels(i,j,k);
    end
end
end

for i = 2:n-1
for l = 2:k-1
    if (labels(i,1,l) && labels(i,m,l)) && (labels(i,1,l) ~= labels(i,m,l))
        labels(labels == labels(i,1,l)) = labels(i,m,l);
    end
end
end

for j = 2:m-1
for l = 2:k-1
    if (labels(1,j,l) && labels(n,j,l)) && (labels(1,j,l) ~= labels(n,j,l))
        labels(labels == labels(1,j,l)) = labels(n,j,l);
    end
end
end

% edge check

for i = 2:n-1
    if (labels(i,1,1) && labels(i,m,1)) && (labels(i,1,1) ~= labels(i,m,1))
        labels(labels == labels(i,1,1)) = labels(i,m,1);
    end
    if (labels(i,1,1) && labels(i,1,k)) && (labels(i,1,1) ~= labels(i,1,k))
        labels(labels == labels(i,1,1)) = labels(i,1,k);
    end
    if (labels(i,m,k) && labels(i,1,k)) && (labels(i,m,k) ~= labels(i,1,k))
        labels(labels == labels(i,m,k)) = labels(i,1,k);
    end
    if (labels(i,m,k) && labels(i,m,1)) && (labels(i,m,k) ~= labels(i,m,1))
        labels(labels == labels(i,m,k)) = labels(i,m,1);
    end
end

for j = 2:m-1
    if (labels(1,j,1) && labels(n,j,1)) && (labels(1,j,1) ~= labels(n,j,1))
        labels(labels == labels(1,j,1)) = labels(n,j,1);
    end
    if (labels(1,j,1) && labels(1,j,k)) && (labels(1,j,1) ~= labels(1,j,k))
        labels(labels == labels(1,j,1)) = labels(1,j,k);
    end
    if (labels(n,j,k) && labels(n,j,1)) && (labels(n,j,k) ~= labels(n,j,1))
        labels(labels == labels(n,j,k)) = labels(n,j,1);
    end
    if (labels(n,j,k) && labels(1,j,k)) && (labels(n,j,k) ~= labels(1,j,k))
        labels(labels == labels(n,j,k)) = labels(1,j,k);
    end
end

for l = 2:k-1
    if (labels(1,1,l) && labels(n,1,l)) && (labels(1,1,l) ~= labels(n,1,l))
        labels(labels == labels(1,1,l)) = labels(n,1,l);
    end
    if (labels(1,1,l) && labels(1,m,l)) && (labels(1,1,l) ~= labels(1,m,l))
        labels(labels == labels(1,1,l)) = labels(1,m,l);
    end
    if (labels(n,m,l) && labels(n,1,l)) && (labels(n,m,l) ~= labels(n,1,l))
        labels(labels == labels(n,m,l)) = labels(n,1,l);
    end
    if (labels(n,m,l) && labels(1,m,l)) && (labels(n,m,l) ~= labels(1,m,l))
        labels(labels == labels(n,m,l)) = labels(1,m,l);
    end
end

% vertex check

% (1,1,1) check
if (labels(1,1,1) && labels(n,1,1)) && (labels(1,1,1) ~= labels(n,1,1))
    labels(labels == labels(1,1,1)) = labels(n,1,1);
end
if (labels(1,1,1) && labels(1,m,1)) && (labels(1,1,1) ~= labels(1,m,1))
    labels(labels == labels(1,1,1)) = labels(1,m,1);
end
if (labels(1,1,1) && labels(1,1,k)) && (labels(1,1,1) ~= labels(1,1,k))
    labels(labels == labels(1,1,1)) = labels(1,1,k);
end

% (n,m,1) check
if (labels(n,m,1) && labels(n,1,1)) && (labels(n,m,1) ~= labels(n,1,1))
    labels(labels == labels(n,m,1)) = labels(n,1,1);
end
if (labels(n,m,1) && labels(1,m,1)) && (labels(n,m,1) ~= labels(1,m,1))
    labels(labels == labels(n,m,1)) = labels(1,m,1);
end
if (labels(n,m,1) && labels(n,m,k)) && (labels(n,m,1) ~= labels(n,m,k))
    labels(labels == labels(n,m,1)) = labels(n,m,k);
end

% (n,1,k) check
if (labels(n,1,k) && labels(n,1,1)) && (labels(n,1,k) ~= labels(n,1,1))
    labels(labels == labels(n,1,k)) = labels(n,1,1);
end
if (labels(n,1,k) && labels(n,m,k)) && (labels(n,1,k) ~= labels(n,m,k))
    labels(labels == labels(n,1,k)) = labels(n,m,k);
end
if (labels(n,1,k) && labels(1,1,k)) && (labels(n,1,k) ~= labels(1,1,k))
    labels(labels == labels(n,1,k)) = labels(1,1,k);
end

% (1,m,k) check
if (labels(1,m,k) && labels(1,m,1)) && (labels(1,m,k) ~= labels(1,m,1))
    labels(labels == labels(1,m,k)) = labels(1,m,1);
end
if (labels(1,m,k) && labels(1,1,k)) && (labels(1,m,k) ~= labels(1,1,k))
    labels(labels == labels(1,m,k)) = labels(1,1,k);
end
if (labels(1,m,k) && labels(n,m,k)) && (labels(1,m,k) ~= labels(n,m,k))
    labels(labels == labels(1,m,k)) = labels(n,m,k);
end

end
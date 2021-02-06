function mat = truncate(mat)

d = length(size(mat));
boo = all(mat==0, [1:d-1]);
tail = find(boo(2:end), 1, 'first')+1;
if isempty(tail)
    return;
end

if d == 2
    mat = mat(:,1:tail-1);
elseif d == 3
    mat = mat(:,:,1:tail-1);
elseif d == 4
    mat = mat(:,:,:,1:tail-1);
elseif d == 5
    mat = mat(:,:,:,:,1:tail-1);
end

end
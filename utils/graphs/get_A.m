function A = get_A(w)

sz = size(w); sz = sz(1:end-1);
dim = length(sz);

if dim == 2   
if size(w,3) == 4
    w = get_ww(w);
end

    N = prod(sz);
    A = sparse(zeros(N,N));
    
    indices = gen_indices(sz); indices1 = circshift(indices,-1,1); indices2 = circshift(indices,-1,2);
    
    indices = reshape(indices,[1 N]); indices1 = reshape(indices1,[1 N]); indices2 = reshape(indices2,[1 N]);
    w1 = reshape(w(:,:,1),[1 N]); w2 = reshape(w(:,:,2),[1 N]);
    
    for i = 1:N
       index = indices(i); index1 = indices1(i); index2 = indices2(i);
       A(index,index1) = w1(i); A(index1,index) = w1(i);
       A(index,index2) = w2(i); A(index2,index) = w2(i);
    end
    
elseif dim == 3
if size(w,4) == 6
    w = get_ww(w);
end
    
    N = prod(sz);
    A = sparse(zeros(N,N));
    
    indices = gen_indices(sz); 
    indices1 = circshift(indices,-1,1); indices2 = circshift(indices,-1,2); indices3 = circshift(indices,-1,3);
    
    indices = reshape(indices,[1 N]); 
    indices1 = reshape(indices1,[1 N]); indices2 = reshape(indices2,[1 N]); indices3 = reshape(indices3,[1 N]);
    w1 = reshape(w(:,:,:,1),[1 N]); w2 = reshape(w(:,:,:,2),[1 N]); w3 = reshape(w(:,:,:,3),[1 N]);
    
    for i = 1:N
       index = indices(i); index1 = indices1(i); index2 = indices2(i); index3 = indices3(i);
       A(index,index1) = w1(i); A(index1,index) = w1(i);
       A(index,index2) = w2(i); A(index2,index) = w2(i);
       A(index,index3) = w3(i); A(index3,index) = w3(i);
    end
    
else
    fprintf('Error');
    return;
end

end
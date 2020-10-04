function G = get_G(w)

sz = size(w); sz = sz(1:end-1); d = length(sz);
N = prod(sz);

if d == 2
    
    indices = gen_indices(sz); indices1 = circshift(indices,-1,1); indices2 = circshift(indices,-1,2);  
    indices = reshape(indices,[1 N]); indices1 = reshape(indices1,[1 N]); indices2 = reshape(indices2,[1 N]);
    s = reshape([indices;indices],[1 2*N]); t = reshape([indices1;indices2],[1 2*N]);
    ind = ~reshape(permute(w,[3 1 2]),[1 2*N]);
    s(ind) = []; t(ind) = []; 
    G = graph(s,t); 
    dn = N-height(G.Nodes);
    if dn
    G = addnode(G,dn);
    end
    
elseif d == 3
    
    indices = gen_indices(sz); indices1 = circshift(indices,-1,1); indices2 = circshift(indices,-1,2); indices3 = circshift(indices,-1,3);
    indices = reshape(indices,[1 N]); indices1 = reshape(indices1,[1 N]); indices2 = reshape(indices2,[1 N]); indices3 = reshape(indices3,[1 N]);
    s = reshape([indices;indices;indices],[1 3*N]); t = reshape([indices1;indices2;indices3],[1 3*N]);
    ind = ~reshape(permute(w,[4 1 2 3]),[1 3*N]);
    s(ind) = []; t(ind) = []; 
    G = graph(s,t); 
    dn = N-height(G.Nodes);
    if dn
    G = addnode(G,dn);
    end
    
else
    fprintf('Error');
    return;
end

end
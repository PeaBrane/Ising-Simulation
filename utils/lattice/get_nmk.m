function [Nlist,nmk] = get_nmk(npara,fRBM)

d = length(npara);

if d == 2
n1 = npara(1); n2 = npara(2);
nmk = repmat((n1:4:n2).',[1 2]);
elseif d == 3
n1 = npara(1); n2 = npara(2); quo = npara(3);
nlist = reshape(repmat(n1:2:n2,[3 1]),[1 3*length(n1:2:n2)]);
nmk = cat(2, nlist.', circshift(nlist.',-1,1), circshift(nlist.',-2,1));
nmk = nmk(1:end-2,:);
if quo > 0
    nmk = cat(1,nmk,[n2 n2+2 n2]);
    if quo > 1
        nmk = cat(1,nmk,[n2 n2+2 n2+2]);
    end
end
end

if ~fRBM
Nlist = prod(nmk,2).';
else
Nlist = sum(nmk,2).'; 
end

end
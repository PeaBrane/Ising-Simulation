function nmk = get_nmk(n1, n2)

% nlist = reshape(repmat(2:2:n,[3 1]),[1 3*length(2:2:n)]);
% nmk = cat(2, nlist.', circshift(nlist.',-1,1), circshift(nlist.',-2,1));
% nmk = nmk(1:end-2,:);
% 
% if quo > 0
%     nmk = cat(1,nmk,[n n+2 n]);
%     if quo > 1
%         nmk = cat(1,nmk,[n n+2 n+2]);
%     end
% end

nlist = reshape(repmat(n1:2:n2,[3 1]),[1 3*length(n1:2:n2)]);
nmk = cat(2, nlist.', circshift(nlist.',-1,1), circshift(nlist.',-2,1));
nmk = nmk(1:end-2,:);

end
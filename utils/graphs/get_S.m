function S = get_S(v0,W)

v = sign(v0);
wp = cat(3, W(:,:,[2 4]), circshift(circshift(W(:,:,[1 3]),-1,1),-1,2));
vd = circshift(circshift(v,-1,1),-1,2);
vb = cat(3, v.*circshift(v,-1,1), v.*circshift(v,-1,2), ...
            vd.*circshift(v,-1,2), vd.*circshift(v,-1,1));
        
S = wp.*vb;

end
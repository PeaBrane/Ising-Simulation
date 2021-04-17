function [W,Esol] = tiling(sz,flist)

d = length(sz);
if flist == 'g'
    w = normrnd(0,1,[sz d]);
    Esol = 0;
elseif flist == 'r'
    w = -1 + 2*round(rand([sz d],'single'));
    w = double(w);
    Esol = 0;
elseif d == 2
    [w,Esol] = tiling_2d(sz(1),sz(2),flist);
elseif d == 3
    [w,Esol] = tiling_3d(sz(1),sz(2),sz(3),flist); 
end

% w = gauge_lattice(w);
W = get_W(w);

end
function [a,b,w,E] = loop_SAT(n,a1,a2,scale,n_loops)

a1 = scale + ceil(scale*a1);
a2 = ceil(0.5*scale) + ceil(scale*a2);

a = zeros(1,2*n);
b = zeros(1,2*n);
w = zeros(2*n,2*n);

vnz = zeros(1,n);
E = 0;

for loop = 1:n_loops
   
    vbase = randsample(n,3).';
    while true
    nrand = n*round(rand(1,3));
    if any(nrand == 0)
        break;
    end
    end
    vlist = vbase + nrand;
    vnegs = vbase + n - nrand;
    
    for i = 1:3
        v0 = vbase(i); v1 = vlist(i); v2 = vnegs(i);
        if vnz(v0) == 0
            vnz(v0) = 1;
        elseif vnz(v0) == 1 && ~w(v1,v1)
            vnz(v0) = 2;
            a(v1) = a(v1) - 2*a2;
            b(v2) = b(v2) - 2*a2;
            w(v1,v2) = w(v1,v2) - a2;
            E = E - a2;
        end    
    end
    
    w(vlist,vlist) = w(vlist,vlist) + loop3(scale,a1);
    E = E + 3*a1 + scale;
    
end

end
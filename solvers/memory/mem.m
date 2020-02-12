function [t,Ebest] = mem(Esol,w,beta,gamma,epsilon,rigid,dt0,t0,d)

Ebest = 0;
dtmin = dt0(1); dtmax = dt0(2);
W = get_W(w);

if d == 2
n = size(W,1); m = size(W,2);
X = 0.5*ones(n,m,4);
elseif d == 3
n = size(W,1); m = size(W,2); k = size(W,3);
X = 0.5*ones(n,m,k,6);
end
    
if d == 2
v = -1 + 2*rand(n,m);
X = 0.5*ones(n,m,4);
elseif d == 3
v = -1 + 2*rand(n,m,k);
X = 0.5*ones(n,m,k,6);
end

t = 0;
while t < t0

[V,~,E] = get_E(v,W);
if E > Ebest
    Ebest = E;
    if Ebest == Esol
        break;
    end
end
    
if d == 2
[C,field] = get_C(v,V,W,2);
G = 0.5*sum((1+X).*field, 3);
R = -rigid*sum((1-X), 3).*v;
elseif d == 3
[C,field] = get_C(v,V,W,3);
G = 0.5*sum((1+X).*field, 4);
R = -rigid*sum((1-X), 4).*v;
end

dir = G+R;
dirmax = max(abs(dir(:)));
dt = min(max( 1/dirmax , dtmin),dtmax);
t = t+dt;

v = max(min( v + dt*dir ,1),-1);
X = max(min( X + dt*beta*(X.*(1-X)+epsilon).*(C-gamma) ,1),0);

end

end
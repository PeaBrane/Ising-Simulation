function [Ebest,t] = mem_graph(Esol,w,beta,gamma,rigid,T,t0,dtlist,quiet)

 = ceil(T/t0);
dtmin = dt0(1); dtmax = dt0(2);
Ebest = 0;
flag = 0;
sz = size(w); sz = sz(1:end-1); 
N = prod(sz); d = length(sz);
W = get_A(w);

for run = 1:runs

v = -1 + 2*round(rand(1,N));
x = ones([sz d]); X = get_A(x);
A = get_A(ones([sz d]));

t = 0;
while t < t0

E = sign(v)*A*sign(v).'/2;
if E > Ebest
    Ebest = E;
    if Ebest == Esol
        flag = 1;
        break;
    end
end

G = 0.5*v*((A+X).*W);
R = -rigid*0.5*v.*(ones(1,N)*(A-X));
C = 0.5*(A - sparse(diag(v))*W*sparse(diag(v)));

dir = G+R;
dirmax = max(abs(dir(:)));
dt = min(max( 1/dirmax , dtmin),dtmax);
t = t+dt;

v = max(min( v + dt*dir ,1),-1);
X = max(min( X + dt*beta*(C-gamma*A) ,1),0);

if ~quiet
mydot(t,t0,dt,1);
end

end

fprintf('\n');

if flag
    break;
end

% fprintf('.');
% if mod(run,100) == 0
%     fprintf('\n');
% end

end

end
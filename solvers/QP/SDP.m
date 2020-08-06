function [Ebest,t] = SDP(Esol,W,T,quiet)

A = -get_A(W);
N = size(A,1);
C = zeros(N,N,N);
for i = 1:N
    C(i,i,i) = 1;
end
    
cvx_begin quiet
variable X(N,N) symmetric
minimize(trace(A*X));
for i = 1:N
    trace(C(:,:,i)*X) == 1;
end
X == semidefinite(N);
cvx_end

t0 = 100; Ebest = 0; flag = 0;
restarts = ceil(T/t0);
for restart = 1:restarts
    
R = sign(mvnrnd(zeros(1,N),X,t0));
for dt = 1:t0
    
E = -R(dt,:)*A*R(dt,:).'/2;       
if E > Ebest
    Ebest = E;
    if Ebest >= Esol
        flag = 1;
        break;
    end
end
    
if ~quiet
    mydot((restart-1)*t0+dt,restarts*t0,1,1);
end
    
end
    
if flag
    break;
end
    
end

t = (restart-1)*t0 + dt;

end
function [wlist,S] = spec(dt,f)

n = length(f);
wlist = (0:n-1)/n/dt*2*pi;
g = fft(f,n,2)*sqrt(dt/n);
S = mean(abs(g).^2,1);

end
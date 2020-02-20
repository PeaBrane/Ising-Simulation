function [y,k] = dft(x,t)

dt = 0.1; tmax = floor(t(end));

t0 = dt:dt:tmax; n = length(t0);
x = interp1(t,x,t0);

y = fft(x);
k = (1:n)/tmax;

end
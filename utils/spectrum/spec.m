function [slist,wlist] = spec(flist,tlist,nt,dt)

flist = interp1(tlist,flist,(1:nt)*dt);
wlist = (0:nt-1)/nt/dt*2*pi;
g = fft(flist,nt,2)*sqrt(dt/nt);
slist = mean(abs(g).^2,1);

end
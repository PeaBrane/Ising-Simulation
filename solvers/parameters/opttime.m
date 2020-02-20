function t = opttime(n,frus)

t = (0.504*n^2 - 13.3*n + 311)*...
          (193*frus^3 - 52.7*frus^2 + 4.73*frus - 0.102);
t = floor(t);

end
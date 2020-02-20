function i = randstep(n,k)

if k == 1
    i = 1 + (n-2)*round(rand());
elseif k == n
    i = -1 - (n-2)*round(rand());
else
    i = -1 + 2*round(rand());
end

end
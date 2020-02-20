function mag = get_mag(v)

d = length(size(v));
mag = reshape(mean(abs(v),1:d-1),[1 size(v,d)]);

end
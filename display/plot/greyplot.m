function greyplot(v,fsave)

N = size(v,3);
m = round(sqrt(N));
n = ceil(N/m);

fig = figure(1);
for Ni = 1:N
vi = v(:,:,Ni);
I = mat2gray(vi,[min(vi(:)) max(vi(:))]);
subaxis(n, m, Ni, 'spacing', 0.01, 'padding', 0, 'margin', 0);
imshow(I);

end

if fsave
    saveas(fig,'plots.png');
end

end
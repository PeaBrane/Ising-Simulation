function [ind,mat] = thin(ind,mat,ref,geo)

if geo
    ind = log(ind); ref = log(ref);
end
n = length(ref); ind_new = []; d = length(size(mat));

for i = 1:n
    i1 = find(ind < ref(i),1,'last');
    i2 = find(ind >= ref(i),1,'first');
    if (ref(i) - ind(i1)) < (ind(i2) - ref(i))
        ind_new = [ind_new i1];
    else
        ind_new = [ind_new i2];
    end
end
        
ind = ind(ind_new);
if d == 2
    mat = mat(:,ind_new);
elseif d == 3
    mat = mat(:,ind_new,:);
elseif d == 4
    mat = mat(:,ind_new,:,:);
elseif d == 5
    mat = mat(:,ind_new,:,:,:);
end

if geo
    ind = exp(ind);
end

end
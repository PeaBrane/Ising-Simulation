function llist = orderseries(list, d1, d2)

llist = reshape(list.' * 10.^[d1:d2], [1 length(list)*(d2-d1+1)]);

end
function list = myinsert(list1,list2,indices)

ll = length(list1)+length(list2);
list = zeros(1,ll);
list(indices) = list2;
list(setdiff(1:ll,indices)) = list1;

end
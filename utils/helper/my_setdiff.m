function c = my_setdiff(a,b)

check = false(1,max(max(a),max(b)));
check(a) = true;
check(b) = false;
c = a(check(a));

end
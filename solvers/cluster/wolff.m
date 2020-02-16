function v = wolff(v,w,beta)

inds = connect(v,w,beta);
v(inds.') = -v(inds.');

end
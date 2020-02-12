function fn = get_fn(list,iter,work)

vars = get_vars(list,iter);
dim = length(vars);

fn = blanks(0);
for d = dim:-1:1
    var = vars(d);
    fn = strcat(fn,num2str(var),'-');
end

fn = fn(1:end-1);
fn = strcat(fn,'-',num2str(work));
fn = strcat(fn,'.mat');

end
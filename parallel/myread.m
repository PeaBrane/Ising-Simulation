function timelist = myread(folder,workers,runs,varlist)

ins = round(runs/workers);

[sz,vl] = collapse(varlist);
tot = prod(sz);
timelist = zeros(1,tot*runs);

for iter = 1:tot 
quo1 = (iter-1)*runs;
for work = 1:workers
quo2 = (work-1)*ins;
    
fn = get_fn(vl,iter,work);
fn = strcat(folder,'/',fn);

if isfile(fn)
   p = load(fn);
   p = p.variable;
   timelist( quo1+quo2+1:quo1+quo2+ins ) = p;
else
   timelist( quo1+quo2+1:quo1+quo2+ins ) = zeros(1,ins);
end

end
mydot(iter,tot,1,1);
end

timelist = reshape(timelist, [runs sz]);

end
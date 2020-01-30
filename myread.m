function timelist = myread(folder,n_list,vers_list,sz_list,frus_list,density_list,runs)

list = {density_list, frus_list, sz_list, vers_list, n_list};

[sz,list] = collapse(list);
dim = length(sz); tot = prod(sz);
timelist = zeros(1,tot*runs);

for tot_iter = 1:tot 

fn = get_fn(list,tot_iter);
    
fn = strcat(folder,'/',fn);

if isfile(fn)
   p = load(fn);
   p = p.variable;
   timelist( (tot_iter-1)*runs+1:tot_iter*runs ) = p;
else
   timelist( (tot_iter-1)*runs+1:tot_iter*runs ) = zeros(1,runs);
end

end

timelist = reshape(timelist, [runs sz]);

end
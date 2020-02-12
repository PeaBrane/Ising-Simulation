function dirname = cnf_dirname(sz,vars)

dirname = blanks(0);

for i = 1:length(sz)  
    dirname = strcat(dirname, num2str(sz(i)), 'x');    
end
dirname(end) = '_';

for i = 1:length(vars)
    dirname = strcat(dirname, num2str(vars(i)), '_'); 
end
dirname(end) = '';

end
function list = get_legend(para, vars)

list = {};

for var = vars
    
    text = strcat(para , '=' , num2str(var));
    text = strcat('{\boldmath$',text,'$}');
    list{end+1} = text;
    
end

end
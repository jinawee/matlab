function f=mac(F)
%F: funcion como cadena de caracteres
%f: funcion como cadena de caracteres
F=['(',F,')']
Frep=strrep(F,'x',['(x+',F,')'])
f=['x-',F,'^2/(',Frep,'-',F,')']

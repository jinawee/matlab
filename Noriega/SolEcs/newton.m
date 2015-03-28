function f=newton(F)
%Devuelve la función del método de Newton
%F: funcion como char (solo admite una variable)
%f: funcion como char
Fp=char(diff(F));
x=char(symvar(F));
f=[x,'-', F,'/',Fp];
function f=newton(F)
%Devuelve la funci�n del m�todo de Newton
%F: funcion como char (solo admite una variable)
%f: funcion como char
Fp=char(diff(F));
x=char(symvar(F));
f=[x,'-', F,'/',Fp];
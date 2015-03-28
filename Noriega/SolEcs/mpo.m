function f=mpo(F)
%Devuelve la función de las proyecciones ortogonales
%F: funcion como char (solo admite una variable)
%f: funcion como char
Fp=char(diff(F));
x=char(symvar(F));
f=[x,'-', F,'*',Fp,'*1+(',Fp,')^2'];
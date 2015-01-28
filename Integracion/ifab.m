function d=ifab(f,coef,nodos)
%
% Sintaxis  d=ifab(f,coef,nodos)
% 
% f       funcion como cadena de caracteres
%                                                  
% coef    coeficientes de la formula para estimar la integral
%         la integral de la funci�n f en el intervalo [a,b]
% nodos   vector de nodos base
%
%                                
% d       estimacion del valor de la integral de f en [a b] 
%
% Ejemplo     [c,n]=cfin([0 .5 1],[0,1]) ; d = ifab('sin(x)',c,n)

f=vectorize(inline(f));
d=f(nodos)*coef; % la formula se calcula como un producto matricial

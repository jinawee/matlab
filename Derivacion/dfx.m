function d=dfx(f,coef,nodos,x)
%
% Sintaxis  d=dfx(f,coef,nodos,x)
% 
% f       funcion como cadena de caracteres
%                                                   (k)
% coef    coeficientes de la formula para estimar  f   (0)
% nodos   vector de nodos base para calcular la formula en alfa=0
% x       punto donde se aproxima  la derivada
%
%                                 (k)
% d       estimacion del valor   f   (x)
%
% Ejemplo     [c,n]=cfdn([0 .1 .2],0,1) ; d = dfx('sin(x)',c,n,pi)

f=vectorize(inline(f));
% la formula se calcula como un producto matricial
d=f(x+nodos)*coef;

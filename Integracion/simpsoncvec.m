function  [i,I]=simpsonc(f,a,b,m)
% Regla de Simpson compuesta
% Sintaxsis:   i=simpsonc(f,a,b,m)
%
% f   funcion como cadena de caracteres
% a,b extremos del dominio
% m   numero de subintervalos
%
% i   estimacion de la integral
%  
%  Ejemplo:     i=simpsonc('exp(x)',0,1,10)
%
f=inline(f);
f=vectorize(f)
x=linspace(a,b,2*m+1);

I=( f(a)+sum(2*f(x(3:2:2*m-1))) + sum(4*f(x(2:2:2*m)))+f(b) )*(x(2)-x(1))/3

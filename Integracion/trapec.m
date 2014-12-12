    function i=simpsonc(f,a,b,m)
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
f=vectorize(f);
h=(b-a)/m;
x=linspace(a,b,m+1);
i=h/2 *( f(a) + 2*sum(f(x(2:m))) + f(b) );
    

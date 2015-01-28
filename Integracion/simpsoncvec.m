    function i=simpsoncvec(f,a,b,m)
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
%h=(b-a)/m;
%x=linspace(a,b,m+1);
%i=h/2 *( f(a) + 2*sum(f(x(2:m))) + f(b) );
x=linspace(a,b,2*m+1);
h=x(2)-x(1);

k=2:2:2*m;
i= h/3 * ( f(a) + 2*sum(f(x(k+1))) + 4*sum(f(x(k))) - f(b));

%Optimizado

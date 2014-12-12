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

x=linspace(a,b,2*m+1);

i2=0;
i4=0;

for k=2:2:2*m
    i2=i2+f(x(k+1));
    i4=i4+f(x(k));  
end
i=(f(a)+2*i2+4*i4-f(b))*(x(2)-x(1))/3;

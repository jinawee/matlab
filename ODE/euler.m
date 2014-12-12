function [t,y]=euler(f,t0,tN,y0,N)

%Implementa el metodo de Euler
%
%Sintaxis:  [t,y]=euler(f,t0,tN,y0,N)
%
%f: funcion que describe la ecuacion diferencial ordinaria como cadena de 
% caracteres, en la forma f(t,y)
%t0, tN: tiempos inicial y finial, respectivamente
%y0: condicion de Cauchy
%N: numero de pasos (iguales)
%
%t: vector tiempos
%y: vector  del método de euler explicito
%
%Ejemplo [t,y]=euler('t*y',0,4,1,200)

t=linspace(t0, tN, N+1);
h=(tN-t0)/N;
f=inline(f,'y','t');
y(1)=y0;
for i=1:N
    y(i+1) = y(i) + h*f( y(i),t(i) ) ;
end
    
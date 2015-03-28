function [t,y]=rungeKutta(f,t0,tN,y0,N)

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
%y: vector  del m�todo de euler explicito
%
%Ejemplo [t,y]=rungeKutta('t*y',0,4,1,200)

t=linspace(t0, tN, N+1);
h=(tN-t0)/N;
f=inline(f,'y','t');
y=zeros(N,1);
y(1)=y0;
for i=1:N
    K1=f( y(i),t(i) );
    K2=f( y(i) + h*K1/2,t(i)+h/2 );
    K3=f( y(i) + h*K2/2,t(i)+h/2 );
    K4=f( y(i) + h*K3,t(i)+h );
    paso=(K1+2*K2+2*K3+K4)/6;
    y(i+1) = y(i) + h*paso ;
end

%Hecho en clase
    
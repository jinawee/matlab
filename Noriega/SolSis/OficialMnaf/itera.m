function [beta,v]=itera(f,x0,nmax,tol,a,b)
%  Visualiza la iteracion de punto fijo para f en [a,b]
%  Sintaxis   [beta,v]=itera(f,a,b,n,col,sem)
%                  -                --- ---
% f     : funcion como cadena de caracteres
% x0    : semilla
% nmax  : numero de iteraciones
% tol   : tolerancia, si |x(k+1)-x(k)|< tol, parada
% a,b   : extremos del dominio
%
% beta  : estimacion del punto fijo
% v     : sucesion de iteracion (opcional)
%
% Ejemplo de uso:          r=itera('cos(x)',0.2,100,1e-5,0,pi)
clc
format long
f=inline(f);
if nargin>4
 ezplot(f,[a b a b])
 axis([a b a b])
 hold on
 plot([a b],[a b],'m')
end 
% bucle principal
x=x0;
v=x;
for i=1:nmax
   y=f(x);
   disp(['x(' num2str(i) ') = ' char(vpa(y,16))]);
   v=[v;y];
   if abs(x-y)<tol
       beta=y;
       return
   end    
   if nargin>4
    title(['x(' num2str(i) ') = ' char(vpa(y,16))])
    plot([x,x],[x,y],'m:')
    plot([x,y],[y,y],'m:')
    pause
   end 
   x=y;
end
beta=x;
 
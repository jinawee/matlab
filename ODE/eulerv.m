function [tn,soln]=eulerv(f,t0,tfin,y0,n,sol)
% Sintaxis    [tn,soln]=eulerv(f,t0,tfin,y0,n,sol)
%
%  f     segundo miembro del sistema de ecuaciones diferenciales del tipo
%        f(t,y(i))
%  t0    t inicial
%  tfin  t final
%  y0    condicion de Cauchy (vector columna)
%  n     numero de subintervalos
%  sol   solucion exacta (opcional)
%
%  tn    particion de [to tfin]
%  soln  solucion numerica
ne=size(f,1);
for i=1:ne
    F(i,1)=sym(f(i,:));
end
h=(tfin-t0)/n;
tn=linspace(t0,tfin,n+1);
y=y0;
soln=y;  
if ne==1
    title('Visualizacion del metodo de Euler')
    plot(t0,y0,'r.')
    hold on
    axis image
end

if nargin==6 & ne==1
    fplot(sol,[t0 tfin],'b')
end
for i=1:n
    t=tn(i);
    yn=y+h*eval(F);
    soln=[soln yn];
    if ne==1
        plot(tn(i+1),yn,'r.');
        plot([tn(i) tn(i+1)],[y yn],'m.-');
        axis image
        pause
    end 
    y=yn;
end

function [tn,soln]=eulerprueba(f,t0,tfin,y0,n,sol)
% Sintaxis    [tn,soln]=eulerv(f,t0,tfin,y0,n,sol)
%
%  f     segundo miembro del sistema de ecuaciones diferenciales
%  t0    t inicial
%  tfin  t final
%  y0    condicion de Cauchy
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
for i=1:n
    t=tn(i);
    yn=y+h*eval(F);
    soln=[soln yn];
    y=yn;
end

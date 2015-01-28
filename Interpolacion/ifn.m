function p=ifn(xp,yp,~)
% Sintaxis   p = ifn (x,y)
%
% x abscisas
% y ordenadas
%
% p interpolante de Lagrange en la forma de Newton
%
% USA  dd
n=length(xp);
d=dd(xp,yp);    % construimos las diferencias divididas
syms x          % hacemos   x   variable simbolica
p=d(n);         % construimos el polinomio en la variable  t
for i=n-1:-1:1
    p=p*(x-xp(i))+d(i);
end
% se representan los puntos de interpolacion y el interpolante
if nargin==3
    plot(xp,yp,'r.')
    pause
    hold on
    fplot(char(p),[min(xp),max(xp)])
end
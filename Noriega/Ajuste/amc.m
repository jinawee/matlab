function [p,c]=amc(xp,yp,n,representa)
%Ajuste por mínimos cuadrados
%
%Entrada
%xp: puntos de abscisas
%yp: puntos de ordenadas
%n:  n es el grado máximo del polinomio de ajuste
%
%Ejemplo
%[p,c]=amc(1:10,(1:10).^2,2)

B=ones(n+1,length(xp));
for i=2:n+1
    B(i,:)=B(i-1,:).*xp;
end

G=B*B.';

h=B*yp.';
c=G\h;


%Forma de Horner
%p=poly2sym(c(end:-1:1)); es más breve
syms x;
p=sym(c(n+1));
for k=n:-1:1
    p=(c(k)+x*p);
end

%Plotting
if nargin==4
    plot(xp,yp,'gx');
    hold on
    ezplot(p,[min(xp),max(xp)])
    pause
    close all
end
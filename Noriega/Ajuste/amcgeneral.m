function [p,c]=amcgeneral(xp,yp,phi,representa)
%Ajuste por mínimos cuadrados
%
%Entrada
%xp: puntos de abscisas
%yp: puntos de ordenadas
%n:  n es el grado máximo del polinomio de ajuste
%
%Ejemplo
%b=char('x','cos(x)','exp(x)')
%[p,c]=amcgeneral(1:10,(1:10).^2,b)

n=size(phi,1);

B=zeros(n,length(xp));
for i=1:n
    %base=inline(phi(i,:));
    base=eval(['@(x)',phi(i,:)]);
    B(i,:)=base(xp);
end


G=B*B.';

h=B*yp.';
c=G\h; 

%Crea la función de ajuste
p=0;
for i=1:n
   p=p+c(i)*sym(phi(i,:));
end

%Plotting
if nargin==4
    plot(xp,yp,'gx');
    hold on
    ezplot(p,[min(xp),max(xp)])
    pause
    close all
end
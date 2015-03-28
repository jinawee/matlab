function x=dico(f,v,n)
% % Sintaxis  x=dico('f',v,n)
%
% x    : estimacion del limite de la sucesion
% f    : expresion de la funcion como cadena de caracteres en la variable x
% v    : vector [v(1) v(2)] dominio 
% n    : si n>1   es el numero de iteraciones
%      : si n<=1  tolerancia del error   
%
% nota: se asume que  f(v(1)).f(v(2)) < 0
%       Ejemplo:   x=dico('x^2-2',[1,2], 10)
%
a=v(1);b=v(2);
f=inline(f);
fa=f(a); fb=f(b);
if fa*fb>0
    disp('No hay cambio de signo en el intervalo')
    x=[];
    return
elseif fa==0
    disp('raiz encontrada')
    x=a;
    return
elseif fb==0
    disp('raiz encontrada')
    x=b;
    return
end  

if n<1
   n=ceil(log2((b-a)/n));
end
figure
clc
subplot(2,1,1);
plot([a b],[0 0],'r')
hold on
fplot(f,[a b]);
title('Grafica de la funcion')
subplot(2,1,2);hold on
title('Visualizacion del proceso')
xlabel(' Subintervalos ')
ylabel(' Numero de iteracion')
format long
for i=1:n
   plot([a b],[i i]);
   axis([v(1) v(2) .5 i+.5]);
   pause
   x=(a+b)/2;
   disp([' x('  num2str(i) ') = ', num2str(x)]);
   fx=f(x);
   if fa*fx < 0
      b=x;
   elseif fa*fx > 0
      a=x;
   else
      disp(' fue encontrada la raiz! ');
      return
   end
   
end



   
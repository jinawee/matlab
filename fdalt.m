function [xp, df]=fd(f,a,b,n)
%Estimar la funcion DERIVADA de f(x)
%en los puntos de una particion equiespaciada 
%del intervalo [a,b] con n puntos
%usando FORMULAS de derivacion numerica con
%tres nodos.
%xp vector de abscisas
%df vector con la estimacion de f'(x) en xp
%f  expresion de una funcion como cadena de caracteres



xp=linspace(a,b,n)
d=(b-a)/n    %distancia entre cada nodo

nodos=xp(1:3)-xp(2)
coefmedio=cfdn(nodos, 0) %calculamos los coeficientes con los primeros tres nodos 
                               %con la derivada a calcular en el centro x=0
coefmedio=double(coefmedio)
                             
for i=2:n-1
    der(i)=dfx(f,coefmedio, nodos,xp(i));
end    




plot(xp(2:(n)),der,'r.')

%coefmedio=[double(coefmedio(1)) double(coefmedio(2)) double(coefmedio(3))]

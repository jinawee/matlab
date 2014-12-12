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

c=double(cfdn(xp(1:3)-xp(1),0))
df(1)=dfx(f,c,xp(1:3)-xp(1),xp(1))

nodos=xp(1:3)-xp(2)
c1=cfdn(nodos, 0) %calculamos los coeficientes con los primeros tres nodos 
                               %con la derivada a calcular en el centro x=0
c1=double(c1)
                             
for i=2:n-1
    df(i)=dfx(f,c1, nodos,xp(i));
end    

c2=double(cfdn(xp(n-2:n)-xp(n),0))
df(n)=dfx(f,c2,xp(n-2:n)-xp(n),xp(n))



plot(xp,df,'r.')

%coefmedio=[double(coefmedio(1)) double(coefmedio(2)) double(coefmedio(3))]

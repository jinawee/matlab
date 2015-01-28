function [xp, df]=fd(f,a,b,n)
%function [xp, df]=fd(f,a,b,n)
%Estimar la funcion DERIVADA de f(x)
%en los puntos de una particion equiespaciada 
%del intervalo [a,b] con n puntos
%usando FORMULAS de derivacion numerica con
%tres nodos.
%xp vector de abscisas
%df vector con la estimacion de f'(x) en xp
%f  expresion de una funcion como cadena de caracteres
%usa cfdn

xp=linspace(a,b,n);
n=length(xp); %numero de puntos
d=(b-a)/n;    %distancia entre cada nodo

coefmedio=cfdn([d-n 0 d+n], 0); %calculamos los coeficientes con los primeros tres nodos 
                               %con la derivada a calcular en el centro x=0
coefmedio=double(coefmedio);
der=ones(n-1,1);

for i=2:(n-1)
    nodos = xp(i-1:i+1);
    der(i)=dfx(f,coefmedio,[d-n 0 d+n],nodos(2)); %Los indices estan mal
end    

plot(xp(2:(n)),der,'r.')

%coefmedio=[double(coefmedio(1)) double(coefmedio(2)) double(coefmedio(3))]

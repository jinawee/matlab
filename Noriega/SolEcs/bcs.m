function [c,d]=bcs(f,a,b,n,rep)
%function [c,d]=bcs(f,a,b,n,rep) 
%f: cadena de caracteres de la funcion
%a,b: límites del intervalo donde se buscan los cambios de signo
%n: niveles de exploracion
%rep: si se pasa como argumento se hace la representacion grafica
%Este programa "explora" la funcion f hasta que encuentre un cambio de
%signo

clc
f=['@(x)' f];
%fplot(f,[a b])
%hold on
%fplot('0',[a,b])
fa=f(a);
if fa*f(b)<0
    c=a;d=b;
    return
end
dx=b-a;
np=1;
for i=1:n
    punto=a+dx/2;
    if nargin==5
        plot(punto,0,'r.')
        pause
        hold on
    end
    for j=1:np
        if fa*f(punto)<0
            c=punto-dx/2;
            d=punto;
            return
        end
        punto=punto+dx;
        if nargin==5
           plot(punto,0,'r.')
           pause
           hold on
        end
    end
    dx=dx/2;
    np=2*np;
end
c=[];
d=[];
disp('Exploración sin éxito para este nivel de exploración')
close all;

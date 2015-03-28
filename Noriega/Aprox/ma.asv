function [p,c]=ma(f,bo,dom,w,representa)
%Halla la mejor aproximación de una función
%
%Entrada
%f: funcion como cadena de caracteres
%bo: base ortonormal en simbólico, se puede usar la salida de gs.m
%dom: vector con los extremos del intervalo, sueles ser los que se pasaron
%a gs.m
%w: funcion peso como cadena de caracteres
%
%Salida
%p: mejor aproximacion
%c: coeficientes del vector
%
%Ejemplo
%bo=gs(char('1','x','x^2'), [0 1],'1')
%[p,c]=ma('sin(pi*x)',bo, [0,1], '1',1)

a=dom(1); b=dom(2);
c=int(bo*f*w,a,b);
p=c*bo.';

if nargin==5
    figure(1)
    ezplot(p,dom)
    hold on
    fplot(f,dom,'r')
    g=[f,'-(',char(p),')'];
    %box on
    %fplot(g,dom,'g')
end
pause
close all


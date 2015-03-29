
%
%  Ejemplo de optimizacion con una funcion a trozos
%
close all
clc
% Se generan abscisas aleatorias en [0 2] y se ordenan
xd=sort(rand(1,100)*2);

% La  function   f.m  contiene la definicion del modelo a tratar
%
% Se evalua   f( c , x )  con  c=[2 1 1/2] en los puntos de   xd
 yd=feval('f',[2,1,1/2],xd);

%  Se añade ruido (con distribucion 'normal' ponderada)
%  yd=yd+xd.*randn(1,100)/50;

% Representacion de la nube de puntos
plot(xd,yd,'.')
axis image

title(' c = [2 1 1/2] ')
% Entrada de la estimacion del vector de coeficientes
c=input(' estimacion del vector de coeficientes ->');
hold on

% Llamada a la funcion que minimiza la funcion   lsqcurvefit   
ce = lsqcurvefit('f',c,xd,yd)

% Representacion de la solucion obtenida
x=linspace(0,2,300);
y=feval('f',ce,x);
plot(x,y,'m')
title([' c* = ' num2str(ce)])
figure(gcf)



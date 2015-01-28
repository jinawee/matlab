function [x,y]=captura(n,ventana)
% Sintaxis   [x,y]=captura(n,ventana)
%                            -------
%
%  n        numero de puntos a capturar
%  ventana  vector de la forma    [x_min , x_max , y_min , y_max]
%           es opcional, por defecto    ventana = [0 1 0 1]
%  x,y      vectores conteniendo las abscisas y ordenadas de los puntos
if nargin==1
    axis([0 1 0 1]);
else
    axis(ventana);
end
grid on
hold on
for i=1:n
    [x(i) y(i)]=ginput(1);
    plot(x(i),y(i),'r.');
end

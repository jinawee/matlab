function d = difdiv(x,y)
% construye las diferencias divididas
%
% x vector de abscisas
% y vector de ordenadas
% d matriz de diferencias divididas
% Ejemplo: u = [1 2 5]; v = [0 3 24]; d = difdiv(u,v)

%esto no saldrá

n = length(x); %calculo la longitud del vector x
% relleno la primera columna de d
for i=1:n
   d(i,1)=y(i);
end
% rellenamos las siguientes columnas de la matriz
for j=2:n
    for i=j:n
        d(i,j)=(d(i,j-1)-d(i-1,j-1))/(x(i)-x(i-j+1));
    end
end
function d = didi(x,y)
% Sintaxis d = didi(x,y)
% x vector de abscisas
% y vector de ordenadas
% 
% didi diferencias divididas

%en vez de alojar los elementos de una matriz se remodela el vector y

n = length(x); 
for i=2:n
   for j=n:-1:i
        y(j)=(y(j)-y(j-1))/(x(j)-x(j-1+1));
    end
end
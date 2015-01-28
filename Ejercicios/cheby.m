function x=cheby (n)
%construye un vector con los nodos de Chebyshev entre -1 y 1 
%n numero de nodos
%x vector conteniendo los nodos

k=0:(n-1);
x=-cos((2*k+1)/(2*n) * pi);


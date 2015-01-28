function x=cheby (n)
%construye un vector con los nodos de Chebyshev
%n numero de nodos
%x vector conteniendo los nodos

k=1:(n-1)
x=-cos((2*k+1)/(2*n) * pi)


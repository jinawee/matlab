function x=triangsup(A,b)
% Resuelve un sistema lineal de ecuaciones Ax=b, donde A es una
% matriz triangular inferior, por sustitucion
%  A   : matriz del sistema, triangular inferior, invertible
%  b   : termino independiente
%  x   : solucion del sistema
n = length(b);
x=zeros(n,1);
x(n)=b(n)/A(n,n);
for i=n-1:-1:1
	x(i)=( b(i) - A(i,i+1:n) * x(i+1:n) )/A(i,i);
end
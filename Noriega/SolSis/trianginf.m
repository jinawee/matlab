function x=trianginf(A,b)
% Resuelve un sistema lineal de ecuaciones Ax=b, donde A es una
% matriz triangular inferior, por sustitucion
%  A   : matriz del sistema, triangular inferior, invertible
%  b   : termino independiente
%  x   : solucion del sistema
n = length(b);
x=zeros(n,1);
x(1)=b(1)/A(1,1);
for i=2:n
	x(i)=( b(i) - A(i,1:i-1) * x(1:i-1) )/A(i,i);
end
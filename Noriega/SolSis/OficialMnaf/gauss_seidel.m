function [x,iter]=gauss_seidel(A,b,nmax,tol, p)
%  Metodo de Gauss-Seidel
%  Resuelve el sistema A*x=b por el metodo de Gauss-Seidel
%  A         : matriz del sistema
%  b         : termino independiente
%  nmax  : numero maximo de iteraciones
%  tol       : cota de error para criterio de parada
%  p         : tipo de norma
% x          : solucion
% iter     : numero de iteraciones en el calculo de x
[n,m]=size(A);
 if n~=m, error('distinto numero de filas y columnas'); end
x0=zeros(n,1); 
 iter=0;
err=tol+1;
xold=x0;
 x=x0;
 while err > tol  &  iter < nmax
 	iter=iter + 1;
 	for i=1:n
                                s=A(i,1:i-1)*x(1:i-1)+A(i,i+1:n)*xold(i+1:n);                                          
                                x(i,1)=(b(i)-s)/A(i,i);
 	 end
err=norm(x-xold, p); 	 
 xold=x; 
 end
 return
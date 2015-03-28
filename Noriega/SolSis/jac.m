function [x,iter]=jacobi(A,b,nmax,tol,p)
%  Metodo de Jacobi
%  Resuelve el sistema A*x=b por el mettodo de Jacobi
%  A         : matriz del sistema
%  b         : termino independiente
%  nmax  : numero maximo de iteraciones
% tol        : cota de error para criterio de parada
%  p         : tipo de norma a utilizar
% x          : solucion
% inter     : numero de iteraciones en el calculo de x
[n,m]=size(A);
  if n~=m, error('distinto numero de filas y columnas'); end
x0=zeros(n,1);  	
 iter=0;
err=tol+1;
 x=x0;
 while err > tol  &&  iter < nmax
 	iter=iter + 1;
 	for i=1:n ; 	       
            s=A(i,[1:i-1, i+1:n])*x([1:i-1,i+1:n]);
 	        xnew(i,1)=(b(i)-s)/A(i,i);
 	 end
err=norm(xnew-x,p); 	 
 x=xnew;
 end
 return
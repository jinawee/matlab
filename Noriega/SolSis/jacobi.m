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
 iter=0;                %índice de iteración
 err=tol+1;             %puesto que MATLAB no tiene un do; while; hay que forzar la entrada al bucle
 x0=zeros(n,1);         %empezamos a iterar en el vector nulo
 xnew=zeros(n,1);  %inicializa el siguiente vector (para calcular los errores)
 x=x0;                  %empezamos en x0
 tic
 while err > tol  &&  iter < nmax %acabamos si se supera el número de iteraciones o se alcanza la precisión
 	iter=iter + 1;      
    for i=1:n	       
        s=A(i,[1:i-1, i+1:n])*x([1:i-1,i+1:n]);
        xnew(i,1)=(b(i)-s)/A(i,i);
    end
    %xnew=diag(1./diag(A)) * ( (-A+diag(diag(A)))*x +b) ;
    %err=norm(xnew-x,p); %calamos error	 
    %x=xnew;
 end
 toc

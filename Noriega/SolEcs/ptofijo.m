function  [beta,v]=ptofijo(f,x0,nmax,tol)
%Búsqueda del punto fijo beta de f
%Criterio de parada: diferencia entre dos iterantes consecutivos < tol

f=inline(f);
%f=str2func(['@(x)', f]);

%v=[x0];
v=zeros(1,nmax);
v(1)=x0;
for i=1:nmax
    beta=f(x0); %x0 es el iterante anterior y beta el actual
    if abs(beta-x0)<tol
        break;
    end
    x0=beta;
    %v=[v,x0];
    v(i+1)=x0;
end



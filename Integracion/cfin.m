function [c,nodos,fo]=cfin(nodos,dominio,w)
%                                                           
% Construye la formula de integracio numerica para estimar la integral
% de f entre a y b.
% con 'nodos' nodos equiespaciados en [0,1] si n es natural y la formula
% con nodos el vector  n  si este es un vector.
% 
% Sintaxis   [c,nodos,fo]=cfdn(n,a,k)
%               --------
% 
% nodos   numero de nodos o vector de nodos
% dominio vector de la forma [a,b], donde a y b son los limites de
%         integracion inferior y superior, respectivamente
% c       coeficientes de la formula
% nodos   vector de nodos
% fo      formula (opcional)
% 
% Ejemplos:  
%               [coef,nodos,formula]=cfin([0 2 3], [0 4]) 

nodos=sym(nodos);
n=length(nodos);
a=dominio(1);
b=dominio(2);
syms x

if nargin == 2
    w=sym('1');
else
    w=sym(w);
end
 
% formulamos la exactitud de la formula para    x    j=0,...,n-1
% y resolvemos el sistema lineal.
m(1,:)=sym(ones(1,n));
%B(1)=sym(b-a);
B(1)=int(w,a,b);

for i=2:n
    m(i,:)=m(i-1,:).*nodos;
%    B(i,1)=(b^i-a^i)/i;
    B(i,1)=int(x^(i-1)*w,a,b);
end
c=m\B;
if nargout==3  %el tercer argumento de salida es la formula
    fo=0;
    for i=1:n
        fo=fo+c(i)*sym(['f(' char(nodos(i)) ')']);
    end
    
    pretty(fo);
end
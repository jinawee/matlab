function [c,nodos,fo]=cfdn(n,a,k)
%                                                           (k)
% Construye la formula de derivacion numerica para estimar  f  (a)
% con n nodos equiespaciados en [0,1] si n es natural y la formula
% con nodos el vector  n  si este es un vector.
% 
% Sintaxis   [c,nodos,fo]=cfdn(n,a,k)
%               ----- --
% 
% n   numero de nodos o vector de nodos
% a   punto de estimacion
% k   orden de derivacion (por defecto k=1)
%
% c      coeficientes de la formula
% nodos  vector de nodos
% fo     formula (opcional)
% 
% Ejemplos:    c = cfdn(3,1/2)
%              [c,nodos] = cfdn(4,0)
%              syms a b ; [coef,nodos,formula] = cfdn([a b],(a+b)/2)
%              syms h ;   [coef,nod,form]=cfdn([0 h 2*h 3*h],h)
%              syms h ;   [c,nod,fo]=cfdn([0 h 2*h],h,2)
if nargin==2
    k=1;
end
if length(n)==1 %Si la longuitud del primer argumento, se interpreta que es el numero de nodos. Si no, se supone que es  un vector.
    nodos=linspace(0,sym(1),n);
else
    nodos=sym(n);
    n=length(n);
end
syms x
%                                                j 
% formulamos la exactitud de la formula para    x    j=0,...,n-1
% y resolvemos el sistema lineal.
m(1,:)=sym(ones(1,n));
b=zeros(n,1);
b(1)=sym(0);
for i=2:n
    m(i,:)=m(i-1,:).*nodos;
    b(i,1)=subs(diff(x^(i-1),k),x,a);
end
c=m\b;

if nargout==3  %el tercer argumento de salida es la formula
    fo=0;
    for i=1:n
        fo=fo+c(i)*sym(['f(' char(nodos(i)) ')']);
    end
    
    pretty(fo);
end

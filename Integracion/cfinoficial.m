function [c,nodos,fo]=cfin(n,v)
% Si n es natural, construye la formula de integracion numerica de 
% Newton-Cotes con  n  nodos  en el intervalo v=[a,b]
% Si n es un vector, usa sus elementos como nodos de cuadratura
% 
% Sintaxis   [c,fo]=cfin(n,v)
%               --
% 
% n         | numero de nodos de Newton-Cotes | vector de nodos |
% v=[a,b]   extremos del dominio
%
% c   coeficientes de la formula
% fo  formula (opcional)
% 
% Ejemplos:    c = cfin(3,[0 1])
%              [c,formula] = cfin(4,[0 2])
%              syms a b ; [c,nodos, formula] = cfin([a b],[a,b])
%              syms h ;   [c,nodos,fo]=cfin([0 h 2*h],[0,2*h])
if length(n)==1
    nodos=linspace(sym(v(1)),sym(v(2)),n);
else
    nodos=sym(n);
    n=length(n);
end
syms x

% formulamos la exactitud de la formula para  x^k  k=0,...,n-1
% y resolvemos el sistema lineal.
%m(1,:)=sym(ones(1,n)); 
m=sym(ones(n,n));
d=zeros(n,1);
d(1)=sym(v(2)-v(1));


for i=2:n
    disp('m')
    tic
    m(i,:)=m(i-1,:).*nodos;
    tic
    toc
    d(i,1)=int(x^(i-1),v(1),v(2));
    toc
end


c=m\d;
%el segundo argumento de salida es la formula
%fo=0;
%for i=1:n
%    fo=fo+c(i)*sym(['f(' char(nodos(i)) ')']);
%end

% clc
%pretty(fo);

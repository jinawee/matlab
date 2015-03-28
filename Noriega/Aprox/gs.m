function b=gs(a,dom,w)
%
% Sintaxis:   bo=gs(base,dom,w)
%                        --- -
% base       matriz de caracteres, cada fila es una funcion de la base
% dom=[a b]  dominio de integracion para el producto escalar
% w          funcion peso (cadena de caracteres)
%
% bo         base ortonormal
%
% Ejemplos   bo=gs(char('1','x','x^2'), [-1 1])
%            bo=gs(char('1','x','x^2'), [0 1],'x')
%            bo=gs(char('1','x','x^2'), [0 inf],'exp(-x)')

% si no se explicita el dominio se toma  [-1 1]
if nargin==1
   c=-1;
   d=1;
else
    c=dom(1);
    d=dom(2);
end
% si no hay tercer argumento w(x)=1
if nargin<3
    w=1;
end
[n,m]=size(a);
% convertimos las funciones de la base en elementos simbolicos
b=sym(zeros(1,n));
for i=1:n
   b(i)=sym(a(i,:));
end

b(1)=simple(b(1)/int(b(1)*b(1)*w,c,d)^.5);
for i=2:n
    aux=sym(0);
   for j=1:i-1
      aux=aux+int(b(i)*b(j)*w,c,d)*b(j);
   end
   b(i)=b(i)-aux;
   b(i)=simple(b(i)/int(b(i)*b(i)*w,c,d)^.5);
end


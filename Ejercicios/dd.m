function y=dd(x,y)
% Sintaxis     d = dd(x,y)
% x abscisas 
% y ordenadas
%
% y vector conteniendo las diferencias divididas
n=length(x);
for i=2:n
   y(i:n)=(y(i:n)-y(i-1:n-1))./(x(i:n)-x(1:n-i+1));
end

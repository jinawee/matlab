function y=didi(x,y)
% Sintaxis     d = didi(x,y)
% x abscisas 
% y ordenadas
%
% didi diferencias divididas

% en vez de alojar los elementos en una matriz se remodela el vector y
n=length(x);
for i=2:n
    for j=n:-1:i
        y(j)=(y(j)-y(j-1))/(x(j)-x(j-i+1));
    end
end

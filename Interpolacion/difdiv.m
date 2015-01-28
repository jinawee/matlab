function d=difdiv(x,y)
% Sintaxis     d = difdiv(x,y)
% x abscisas 
% y ordenadas
%
% difdiv diferencias divididas

% Se alojan los elementos en una matriz d
n=length(x);
d=zeros(n,n);
d(:,1)=y';
for j=2:n
    for k=j:n
        d(k,j)=(d(k,j-1)-d(k-1,j-1))/(x(k)-x(k-j+1));
%        disp(k),disp(j),disp(d(k,j))
    end
end

%Optimizado
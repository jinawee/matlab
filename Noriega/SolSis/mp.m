function x=mp(A,x,nit)
%Halla un vector propio por el método de la potencia y el valor propio
%correspondiente

for i=1:nit
  x=A*x;
  x=x/norm(x);
end

w=A*x;

x=x(x~=0);
w=w(x~=0);

lambda=w./x;

disp(num2str(mean(lambda)))

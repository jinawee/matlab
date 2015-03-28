function [s,iter]=secante(f,x0,x1,nmax,tol)
%JOHN LIU ANTA
%f: función como cadena de caracteres
%x0, x1: semillas iniciales
%nmax: número de iteraciones
%tol: tolerancia

xold=x0;
x=x1;

f=inline(f);
s=[];
for iter=1:nmax
    if abs(x-xold)<tol
        break;
    else
        s=[s,x];
        xtemp=x;
        x=x-f(x)*(x-xold)/(f(x)-f(xold));
        xold=xtemp;
    end
end


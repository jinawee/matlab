function y=fun(c,x)
global grafica
y=c(1)*x+c(2)*exp(-c(3)*x);
set(grafica,'ydata',y);
pause(.05)
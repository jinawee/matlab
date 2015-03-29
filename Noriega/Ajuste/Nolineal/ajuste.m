function c=ajuste(f,x,y,c)
global grafica
plot(x,y,'r.')
hold on
grafica=plot(x,y);
pause
axis([min(x) max(x) min(y) max(y)]);
c=lsqcurvefit(f,c,x,y);
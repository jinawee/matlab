function [y] = prueba(x)
y= (x>0.4 & x<0.6) .*( (10*x-4).^2)  .* (6-10*x).^2 ;
end
%El orden de convergencia es aproximadamente 1.6 (en teoría sería el número áureo), 
%se comprueba ejecutando:
%
s=secante('x^2-2',2,1.5,20,1e-10);
e=abs(s-sqrt(2));
e(2:end)./e(1:end-1).^1.6
%
%La forma de hallar el orden de convergencia es la siguiente.
%
%Puesto que si el método tiene orden de convergencia p, se cumplirá e(n+1)/e(n)^p=k,
%donde k es una constante, podemos igualar este cociente al cociente de otros dos 
%errores consecutivos (para eliminar k).
%Se obtiene (e(m)/e(n))^p=e(m+1)/e(n+1), donde m es distinto de n.
%Tomando logaritmos, se obtiene que p es:
%p=log(e(m+1)/e(n+1))/log(e(m)/e(n))
%Habría que ejecutar:
m=1:4; n=5;
p=log(e(m+1)./e(n+1))./log(e(m)./e(n))
%Podría hacerse la media de los p, pero al haber tan pocos datos casi no
%merece la pena.

%Ejemplo para calcular el error mediante la norma de f y la norma de la
%mejor aproximación

bo=gs(char('1','x','x^2','x^3'), [-1 1])
[p,c]=ma('exp(x)',bo, [-1,1], '1',0)

f2=int('exp(x)^2',-1,1)
coefs=c*c.'
double(sqrt(f2-coefs))
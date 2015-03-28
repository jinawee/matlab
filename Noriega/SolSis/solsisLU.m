function sol=solsisLU(A,b)

assert(det(A)~=0,'La matriz A tiene determinante nulo')

[L,U]=dlu(A);
y=trianginf(L,b);
sol=triangsup(U,y);

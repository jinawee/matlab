function Pn=legendrepol(n)

syms x;
Pn=[1/2*2^(1/2) 1/2*x*6^(1/2)];
n=2:n;
%Pn(3:n)=( (2*(n-1)+1)*sym(x)*Pn(n-1)-(n-1).*Pn(n-2))./(n)

for j=2:n+1
    Pn(j+1) = ( (2*(j+1)+1)*x*Pn(j-1+1) - (j+1)*Pn(j-2+1) ) /(2*(j+1)+1);
end    

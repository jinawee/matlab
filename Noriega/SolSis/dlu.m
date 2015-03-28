function [L,U]=dlu(A)
%function [L,U]=dlu(A)
%Devuelve la descomposición LU de la matriz A

n=length(A);

U=zeros(n);
L=diag(ones(1,n));

U(1,:)=A(1,:);
L(:,1)=A(:,1)/U(1,1);

for i=2:n
        U(i,i:n)=A(i,i:n)-L(i,1:i-1) * U(1:i-1,i:n);
        L(i+1:n,i)=1/U(i,i) *  (  A(i+1:n,i)-L(i+1:n,1:i-1) * U(1:i-1,i) );
end
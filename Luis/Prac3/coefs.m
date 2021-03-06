%Define constantes
hbar=1.05e-34; %in J*s
m=9.11e-31; %electron's mass in kg
V0=0.3*1.6e-19 %in J
b=15e-9;   %in m

%Contantes q y k que dependen de la energ�a
q=@(E)sqrt((2*m/hbar^2)*(V0-E));
k=@(E)sqrt((2*m/hbar^2)*E);

%Matriz de transferencia final
M11=@(E) cosh(q(E)*b)-((k(E).^2-q(E).^2))./(2*1i*k(E).*q(E)).*sinh(q(E)*b);
M12=@(E)(k(E).^2+q(E).^2)./(2*i*k(E).*q(E)).*sinh(q(E)*b);

%Coeficientes de transmisi�n y reflexi�n de la barrera
r=@(E)-conj(M12(E))./conj(M11(E));
t=@(E)(M11(E)+M12(E).*r(E)).*exp(-i*k(E)*b);
%t=@(E)1./M11(E);
T=@(E) t(E).*conj(t(E));
%T=@(E)1./conj(M11(E)).*exp(-1i*k(E)*b)
Ex=linspace(0.2,0.5,10000)*1.6e-19;
Ty=T(Ex);
maxT=max(Ty);
plot(Ex,Ty);
pause;
E=5.827e-20;
%E=4.905e-20;
q=q(E); k=k(E); r=r(E); t=t(E);

%Matriz de transferencia parcial
MA(1,1)=0.5*(1+k./q);
MA(2,2)=MA(1,1);
MA(1,2)=0.5*(1-k./q);
MA(2,1)=MA(1,2);

%Halla los coeficientes de la fucni�n de onda
A=[1 r]';
B=MA*A;
C=[t 0]';

%Define tres funciones
psi1=@(z) A(1)*exp(i*k*z)+A(2)*exp(-i*k*z);
psi2=@(z) B(2)*exp(q*(z))+B(1)*exp(-q*(z));
psi3=@(z) C(1)*exp(i*k*z);

%Representa cada regi�n
z=linspace(-15e-9,0,1000);
plot(z,real (psi1(z)));
hold on;
z=linspace(0,15e-9,10000);
plot(z,real(psi2(z)));
z=linspace(15e-9,30e-9,10000);
plot(z,real(psi3(z+15e-9)));
pause;
close all;
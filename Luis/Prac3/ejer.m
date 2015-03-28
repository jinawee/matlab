%Define constantes
hbar=1.05e-34; %in J*s
m=0.2*9.11e-31; %electron's mass in kg
V0=0.3*1.6e-19; %in J
b=15e-9;   %in m
d=10e-9;   %in m

%Contantes q y k que dependen de la energía
q=@(E)sqrt((2*m/hbar^2)*(V0-E));
k=@(E)sqrt((2*m/hbar^2)*E);

%Matriz de transferencia final
M11=@(E) cosh(q(E)*b)-((k(E).^2-q(E).^2))./(2*1i*k(E).*q(E)).*sinh(q(E)*b);
M12=@(E)(k(E).^2+q(E).^2)./(2*i*k(E).*q(E)).*sinh(q(E)*b);

E0=0.29*1.6e-19; Emax=0.5*1.6e-19;
npts=10000;
energias=linspace(E0,Emax,npts);
T=zeros(1,npts);

%E=5.827e-20;

for n=1:npts
m11=M11(energias(n)); m12=M12(energias(n)); K=k(energias(n));
%q=q(E); k=k(E); 

MT(1,1)=m11; MT(1,2)=m12; 
MT(2,1)=conj(m12); MT(2,2)=conj(m11);
MP(1,1)=exp(1i*K*(d+b)); MP(2,2)=exp(-1i*K*(d+b)); MP(1,2)=0;MP(2,1)=0;
S=MT*MP*MT;
S=(MT*MP*MT)^9;

T(n)=1/(S(2,2)*conj(S(2,2)));
end

plot(energias/1.6e-19,T)

pause;
close all;



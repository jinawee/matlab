%CTES
%%%%%%%%%%%%%%%%%%%%
lo=632.8e-9;    %longitud de onda
c=3e8;          %velocidad de la luz
tau=lo/c;       %periodo de la onda

paso=10;
t0=20*tau;     %tiempo del maximo del pulso gaussiano
sigma=2*tau;  %dispersion del pulso
dz=lo/10;       %tama�o del intervalo espacial
dt=dz/(2*c);    %tama�o del intervalo temporal
nz=2000; nt=3000; %n�mero de nodos espaciales y temporales
t=0;            %tiempo inicial  
z=dz*(1:nz)*1e6;%creamos las posiciones en micras
%inicializa los vectores de campo E y H (mas rapido que E(1:nz)=0
E=zeros(1,nz); H=zeros(1,nz);

zf=nz*dz*1e6; %posicion final
%f=@(t)exp(-0.5*((t-zf/3)/2).^2);  %puslo gaussiano como fuente
E=sin(z/20);
J=@(t)0;

for n=1:nt
    for i=2:nz-1 %Calcula E en todos los puntos menos en los extremos
        E(i)=E(i)+0.5*( H(i-1)-H(i) );
    end 

    %Inserta fuente en el centro
    E(nz/2)=E(nz/2)+J(t);
    
    for i=1:nz-1 %Calcula H menos en el extremo derecho
        H(i)=H(i)+0.5*( E(i)-E(i+1) );
    end

    t=n*dt; %incrementa tiempo
    
    %GRAFICAS

    if not(mod(n,paso))
      axis([0 zf -1 1]);
      plot(z,E,'g',z,H,'r')
      xlabel('z(micras)')
      axis([0 zf -1 1]);
      frame=getframe(gca);

    end
end
     
close all
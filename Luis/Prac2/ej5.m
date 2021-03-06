close all
%CTES
%%%%%%%%%%%%%%%%%%%%
lo=632.8e-9;    %longitud de onda
c=3e8;          %velocidad de la luz
tau=lo/c;       %periodo de la onda
epsilonr=3;     %entre 1.5 y 3.5
epsilon=[ones(1,400),epsilonr*ones(1,300),ones(1,600),epsilonr*ones(1,300),ones(1,400)];
length(epsilon);
s=0;%.15;
s=[zeros(1,400),s*ones(1,300),zeros(1,600),s*ones(1,300),zeros(1,400)];


paso=20;
t0=20*tau;     %tiempo del maximo del pulso gaussiano
sigma=2*tau;  %dispersion del pulso
J=@(t)cos(2*pi*c/(650e-3)*t*10000);  %puslo gaussiano como fuente
dz=lo/10;       %tama�o del intervalo espacial
dt=dz/(2*c);   %tama�o d10el intervalo temporal
nz=2000; nt=5000; %n�mero de nodos espaciales y temporales
t=0;            %tiempo inicial  
z=dz*(1:nz)*1e6;%creamos las posiciones en micras
%inicializa los vectores de campo E y H (mas rapido que E(1:nz)=0
E=zeros(1,nz); H=zeros(1,nz);


%condiciones de contorno absorbente
low1=0;
low2=0;
high2=0;
high1=0;

zf=nz*dz*1e6; %posicion final
valor=0; si=1;

%Empieza gráfica en el tiempo inicial
figure(1);clf;
gra=plot(z,E,'r');%,'erasemode','xor'); 
hold on
grb=plot(z,H,'b');%,'erasemode','xor');
xlabel('z(micras)')
axis([0 zf -1.5 1.5]);
legend('E','H')

s1=zeros(nt,nz);
s2=zeros(nt,nz);



for n=1:nt
    for i=2:nz-1 %Calcula E en todos los puntos menos en los extremos
        E(i)=(1-s(i))*(1+s(i))*E(i)+0.5/(epsilon(i)*(1+s(i)))*( H(i-1)-H(i) );
    end 

    %Inserta fuente en el centro
    E(nz/2)=E(nz/2)+J(t);
    
    %condiciones de contorno absorbentes
    E(1) = low2;
    low2 = low1;
    low1 = E(2);
    E(nz)= high2;
    high2= high1;
    high1= E(nz-1);
    for i=1:nz-1 %Calcula H menos en el extremo derecho
        H(i)=H(i)+0.5*( E(i)-E(i+1) );
    end
    t=n*dt; %incrementa tiempo
    
    %GRAFICAS
    if valor>E(nz-1) & si
        disp(n*dt*1e15);
        pause;
        si=0;
    else
    s1(n,:)=E;
    valor=E(nz-1);
    end

    if ~mod(n,paso)
     set(gra,'ydata',E);
     set(grb,'ydata',H);
     drawnow
    end
end

%Muestra mapa de calor
figure(2)
colormap('jet')

%s=zeros(nt,nz);
%file=fopen('datos','r')
% A=fscanf(file,'%f');
%for i=1:nt
%    s(i,:)=A(1+nz*(i-1):i*nz,1);
%end
imagesc([0 zf],[0 nt*dt],s1)
colorbar()
xlabel('z(micras)')
pause;
close all

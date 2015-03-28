%CTES
%%%%%%%%%%%%%%%%%%%%
lo=632.8e-9;    %longitud de onda
c=3e8;          %velocidad de la luz
tau=lo/c;       %periodo de la onda

paso=100;
t0=20*tau;     %tiempo del maximo del pulso gaussiano
sigma=2*tau;  %dispersion del pulso
J=@(t)exp(-0.5*((t-t0)/sigma).^2);  %puslo gaussiano como fuente
dz=lo/10;       %tama�o del intervalo espacial
dt=dz/(2*c);    %tama�o del intervalo temporal
nz=2000; nt=1000; %n�mero de nodos espaciales y temporales
t=0;            %tiempo inicial  
z=dz*(1:nz)*1e6;%creamos las posiciones en micras
%inicializa los vectores de campo E y H (mas rapido que E(1:nz)=0
E=zeros(1,nz); H=zeros(1,nz);

zf=nz*dz*1e6; %posicion final

%Crea matrices
id=diag(ones(1,nz));
A=-id+circshift(id,1);
A(1,:)=0;A(nz,:)=0;
B=-A';
B(1,1)=1; B(1,2)=-1;
t=(1:nt)*dt;
J=J(t);

%Empieza gr�fica en el tiempo inicial
disp('Prepara graficas')
figure(1);clf;
gra=plot(z,E,'r');%,'erasemode','xor'); 
hold on
grb=plot(z,H,'b');%,'erasemode','xor');
xlabel('z(micras)')
axis([0 zf -3.1 3.1]);
legend('E','H')

s1=zeros(nt,nz);
s2=zeros(nt,nz);
E=E';H=H';J=J';
tic
disp('Empieza bucle')
for n=1:nt
    E=0.5*A*H+E;
    %Inserta fuente en el centro
    E(nz/2)=E(nz/2)+J(n);  
    H=0.5*B*E+H;    
   % s1(n,:)=E;
   % s2(n,:)=H;
end
toc
%GRAFICAS
disp('Empieza graficas')
pause;
for n=1:nt
    if ~mod(n,paso)
     set(gra,'ydata',s1(n,:));
     set(grb,'ydata',s2(n,:));
     drawnow
    end 
end

figure(2)
colormap('jet')
imagesc(s1)
colorbar()
xlabel('z(micras)')
pause;
   
close all
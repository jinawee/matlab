%CTES
%%%%%%%%%%%%%%%%%%%%
lo=632.8e-9;    %longitud de onda
c=3e8;          %velocidad de la luz
tau=lo/c;       %periodo de la onda
epsilonr=3;
epsilon=[ones(1,1200),epsilonr*ones(1,400),ones(1,400)];


paso=20;
t0=20*tau;     %tiempo del maximo del pulso gaussiano
sigma=2*tau;  %dispersion del pulso
J=@(t)exp(-0.5*((t-t0)/sigma).^2);  %puslo gaussiano como fuente
dx=lo/10;       %tama�o del intervalo espacial
dt=dx/(2*c);   %tama�o d10el intervalo temporal
dy=dx;         %cuadrado
nx=2000; nt=500; %n�mero de nodos espaciales y temporales
ny=nx;
t=0;            %tiempo inicial  
x=dx*(1:nx)*1e6;%creamos las posiciones en micras
%inicializa los vectores de campo E y H (mas rapido que E(1:nz)=0
E=zeros(nx,ny); Hx=zeros(nx,ny); Hy=zeros(nx,ny);
size(Hx)

%condiciones de contorno absorbente
%low1=0;
%low2=0;
%high2=0;
%high1=0;

xf=nx*dx*1e6; %posicion final
%valor=0; si=1;
for n=1:nt
    for i=2:nx-1 %Calcula E en todos los puntos menos en los extremos
        for j=2:ny-1
          E(i,j)=E(i,j)+0.5*( Hx(i,j-1)-Hx(i,j)-Hy(i,j)+Hy(i-1,j) );
        end 
    end

    %Inserta fuente en el centro
    %E(nx/2-500)=E(nx/2-500)+J(t);
    
    %condiciones de contorno absorbentes
    %E(1) = low2;
    %low2 = low1;
    %low1 = E(2);
    %E(nx)= high2;
    %high2= high1;
    %high1= E(nx-1);
    for i=1:nx-1 %Calcula H menos en el extremo derecho
        for j=1:ny-1
            Hx(i,j)=Hx(i,j)+0.5*( E(i,j)-E(i,j+1) );
            Hy(i,j)=Hy(i,j)+0.5*( E(i,j)-E(i+1,j) );
        end
    end
    t=n*dt; %incrementa tiempo
    
    %GRAFICAS
    %if valor>E(nx-1) & si
    %    disp(n*dt*1e15);
    %    pause;
    %    si=0;
    %else
    %valor=E(nx-1);
    %end
    %if not(mod(n,paso))
    %  axis([0 zf -3.1 3.1]);
    %  plot(z,E,'g',z,H,'r')
    %  xlabel('z(micras)')
    %  %legend('E','H')
    %  title(n*dt*1e15);
    %  axis([0 zf -3.1 3.1]);
    %  frame=getframe(gca);
    %end
end
     
close all

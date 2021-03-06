function [x,u]=ecadveccion_perd(t0,tf,nt,a,b,nx,ci,c,cada,sup)
%function [x,u]=ecadveccion_perd(t0,tf,nt,a,b,nx,ci,c,cada)
%ecuacion de advección por el método lax-wendroff con condiciones de
%contorno periódicas

%Crea el vector de tiempos y espacios. Crea "r" y "1-2*r".
x=linspace(a,b,nx); dx=x(2)-x(1); x=x';
dt=(tf-t0)/nt;
r=-dt*c/(2*dx); 

%Test de estabilidad
if 1>dx/(c*dt)
    clc
    disp('No se cumple el test de estabilidad')
    disp(dx/(c*dt))
    pause
end

%Crea la matriz A
disp('Creando A')
A=diag((1-4*r^2)*ones(nx,1),0)+diag(r*(-1+2*r)*ones(nx-1,1),1)+diag(r*(1+2*r)*ones(nx-1,1),-1);
A(1,1)=(1+2*r); A(nx,nx)=0; A(1,2)=-2*r; A(nx,nx-1)=0; A(nx,1)=1; %Condicion de contorno periodicas REVISAR

disp('Creando u')
ci=inline(ci,'x');
u=double(ci(x));

z=ones(length(u),nt); %Reserva espacio para la superficie
z(:,1)=u; %Almacena primera distribucion de temperaturas para la superficie

disp('Calculando la solucion')
for i=1:nt-1
    u=A*u;
    z(:,i+1)=u; %Almacena nueva distribucion de temp. para la superficie
end

disp('Empieza graficas')

%get(gcf,'DoubleBuffer')
%set(gcf, 'DoubleBuffer','on')

gra=plot(x,z(:,1),'erasemode','xor'); %Grafica de la condición incial
axis([a b min(z(:,1)) max(z(:,1))])
pause


for i=1:nt-1 %Muestra nueva distribución
    if mod(i,cada)==0
        set(gra,'ydata',z(:,i)); 
    end
end




pause
close all
    
if sup==1
    figure
    surfc(z);shading interp; colormap(hot);set(gca,'ydir','reverse');
    rotate3d

    pause
    close all
end

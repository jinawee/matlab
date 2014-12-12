function [u]=eccalor(t0,tf,nt,a,b,nx,ci,cca,ccb,alpha,graficasi)
%function dx=eccalor(t0,tf,nt,a,b,nx,ci,cca,ccb,alpha,graficasi)
%graficasi=0 solo es valido para condiciones de contorno constantes en el tiempo

%Crea el vector de tiempos y espacios. Crea "r" y "1-2*r".
x=linspace(a,b,nx); dx=x(2)-x(1); x=x';
t=linspace(t0,tf,nt); dt=t(2)-t(1); t=t';
r=dt/dx^2*alpha^2; 
rdiag=1-2*r;

%Test de estabilidad
if r>.5
    clc
    disp('No se cumple el test de estabilidad')
    disp(r)
    pause
end

%Crea la matriz A
disp('Creando A')
A=diag(rdiag*ones(nx,1),0)+diag(r*ones(nx-1,1),1)+diag(r*ones(nx-1,1),-1);
A(1,1)=1; A(nx,nx)=1; A(1,2)=0; A(nx,nx-1)=0;

disp('Creando u')
ci=inline(ci,'x'); %Crea el vector condición inicial 
u=ci(x);
if length(u)==1
    u(1:nx)=u;
    u=u';
end


disp('Creando cond. contorno')
cca=inline(cca,'t'); %NOTA:"inline" se eliminará en posteriores versiones
ccb=inline(ccb,'t');
cca=cca(t); ccb=ccb(t);

if graficasi==0 %Si no queremos ver paso a paso la sol. 
    u(1)=cca(1); u(end)=ccb(1);
    disp('Calculando la solucion')
    tic
    u=A^nt*u;
    toc
    plot(x,u)
    pause
    close all
end

if graficasi==1  %Si queremos ver paso a paso la sol.
    if length(cca)==1 %Si la función era constante, se crea un vector con ese valor  
        cca(1:nt)=cca;         %(NOTA: menos eficiente para muchas divisiones espaciales)
    end
    if length(ccb)==1
        ccb(1:nt)=ccb;
    end
    u(1)=cca(1); u(end)=ccb(1); %Sustituye las condiciones de contorno en la distribución inicial
    
    z=ones(length(u),nt); %Reserva espacio para la superficie
    z(:,1)=u; %Almacena primera distribucion de temperaturas para la superficie
    
    disp('Calculando la solucion')
     tic
    for i=1:nt-1
       
        u=A*u;
        u(1)=cca(i); u(end)=ccb(i);
        z(:,i+1)=u; %Almacena nueva distribucion de temp. para la superficie
       
    end
    toc
    
    disp('Empieza graficas')
    gra=plot(x,z(:,1),'erasemode','xor'); %Grafica de la condición incial
    axis([a b min(z(:,1)) max(z(:,1))])
    pause
    
    for i=1:nt-1 %Muestra nueva distribución
        set(gra,'ydata',z(:,i)); 
    end
    
    pause
    close all

    figure
    surfc(z);shading interp; colormap(hot);set(gca,'ydir','reverse');
    rotate3d

    pause
    close all
end

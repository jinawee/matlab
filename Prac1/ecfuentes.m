function [u]=ecfuentes(t0,tf,nt,a,b,nx,ci,cca,ccb,cada,graficasi,lamb)
%function [u]=ecfuentes(t0,tf,nt,a,b,nx,ci,cca,ccb,cada,graficasi,lamb)
%graficasi=0 solo es valido para condiciones de contorno constantes en el tiempo
%lamb: es el vector con las constantes de difusión
%a=[13.1*ones(25,1);130*ones(50,1);60*ones(50,1);13.1*ones(25,1)].*10^-6

%Datos
sigma=15e-2;
Q0=0.4;
Q=@(x)exp(-((x-0.75)./sigma).^2)*Q0;

%Crea el vector de tiempos y espacios. Crea "r" y "1-2*r".
x=linspace(a,b,nx); dx=x(2)-x(1); x=x';
t=linspace(t0,tf,nt); dt=t(2)-t(1); t=t';
r=dt/dx^2*max(lamb);  %r solo se usa en el test de estabilidad


%Test de estabilidad
if r>.5
    clc
    disp('No se cumple el test de estabilidad')
    disp(r)
    pause
end



%Crea la matriz A
disp('Creando A')
lplus=.5*(lamb+circshift(lamb,[1,-1]));
lminus=.5*(lamb+circshift(lamb,[1,1]));
D=dt/(dx^2);

diagonal=diag(1-D*(lplus+lminus));
diaginf=D*diag(lplus,-1); diaginf=diaginf(2:end,2:end);
diagsup=D*diag(lminus,1); diagsup=diagsup(1:end-1,1:end-1);
A=diagonal+diaginf+diagsup;

A(1,1)=1; A(nx,nx)=1; A(1,2)=0; A(nx,nx-1)=0;
 

disp('Creando u')
ci=inline(ci,'x'); %Crea el vector condición inicial 
u=ci(x);
if length(u)==1
    u(1:nx)=u;
    u=u';
end

disp('Creando Q')
Q=Q(x);


disp('Creando cond. contorno')
cca=inline(cca,'t'); %NOTA:"inline" se eliminará en posteriores versiones
ccb=inline(ccb,'t');
cca=cca(t); ccb=ccb(t);

if graficasi==0 %Si no queremos ver paso a paso la sol. 
    u(1)=cca(1); u(end)=ccb(1);
    disp('Calculando la solucion')
    Id=ones(nx,nx)^0;
    disp('Matriz casi singular')
   % det(A);
   % serie=(Id-A)^-1*(Id-A^(nt-1));
   % serie=zeros(nx);
    for i=1:nt-1
       u=A*u+dt*Q;
    end
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
        u=A*u+Q*dt;
        u(1)=cca(i); u(end)=ccb(i);
        z(:,i+1)=u; %Almacena nueva distribucion de temp. para la superficie
    end
    toc
    
    disp('Empieza graficas y calcula E')
    gra=plot(x,z(:,1),'erasemode','xor'); %Grafica de la condición incial
    axis([a b min(z(:,1)) max(z(:,1))])  ;          
    pause
    
    for i=1:nt-1 %Muestra nueva distribución
        if mod(i,cada)==0
            set(gra,'ydata',z(:,i)); 
        end
    end
    
    pause
    close all

    figure
    surfc(z);shading interp; colormap(hot);set(gca,'ydir','reverse');

    pause
    close all
end

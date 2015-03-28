function [u,E]=eccalor2(t0,tf,nt,a,b,nx,ci,cca,ccb,cada,graficasi,lamb)
%function [u,E]=eccalor2(t0,tf,nt,a,b,nx,ci,cca,ccb,graficasi,lamb)
%graficasi=0 solo es valido para condiciones de contorno constantes en el tiempo
%lamb: es el vector con las constantes de difusion

%Crea el vector de tiempos y espacios. Crea "r" y "1-2*r".
x=linspace(a,b,nx); dx=x(2)-x(1); x=x';
t=linspace(t0,tf,nt); dt=t(2)-t(1); t=t';
r=dt/dx^2*lamb(1); 
Q0=0.4;


%Test de estabilidad
if r>.5
    clc
    disp('No se cumple el test de estabilidad')
    disp(r)
    pause
end

%[u,E]=eccalor2(0,10,100,0,1.5,150,'80*x.^2-20*x+50','50','200',1,1,a');
%a=[13.1*ones(25,1);130*ones(50,1);60*ones(50,1);13.1*ones(25,1)].*10^-6



%%ENERGIA
E=ones(nt,1);

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
if length(u)==1 %Para condiciones iniciales constantes
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
    u=A^nt*u;
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

    for i=1:nt-1
        u=A*u;
        u(1)=cca(i); u(end)=ccb(i);
        for j=2:nx
            E(i)=1/(2*dx) * lminus(j)*(u(j)-u(j-1))^2;
        end
       % z(:,i+1)=u; %Almacena nueva distribucion de temp. para la superficie
       
    end
    
    
    disp('Empieza graficas y calcula E')
    gra=plot(x,z(:,1),'erasemode','xor'); %Grafica de la condición incial
    axis([a b min(z(:,1)) max(z(:,1))])  ;          
    pause
    
    for i=1:nt-1 %Muestra nueva distribución
        %Descomentar para mostrar la evolucion de T
        %if mod(i,cada)==0
        %    set(gra,'ydata',z(:,i)); 
        %end
        
      %  sumar=lminus'.*( z(:,i)-circshift(z(:,i),[1,1]) ).^2;    
      %  suma=sum(sumar(3:nx-1));
      %  E(i,1)=1/(2*dx)* suma;
        
    end
    
    pause 
    close all

  %  figure
  %  surfc(z);shading interp; colormap(hot);set(gca,'ydir','reverse');
  %  rotate  3d

    pause
    close all
    plot(t(1:nt-1),E(1:nt-1))
    pause
    close all
end

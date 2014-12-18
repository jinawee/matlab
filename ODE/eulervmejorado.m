function [tn,soln]=eulervmejorado(f,t0,tfin,y0,n,sol)
% Sintaxis    [tn,soln]=eulerv(f,t0,tfin,y0,n,sol)
%
%  f     segundo miembro del sistema de ecuaciones diferenciales del tipo
%        f(t,y(i))
%  t0    t inicial
%  tfin  t final
%  y0    condicion de Cauchy (vector columna)
%  n     numero de subintervalos
%  sol   solucion exacta (opcional)
%
%  tn    particion de [to tfin]
%  soln  solucion numerica
%Ejemplo: [t,solna]=eulervmejorado(char('-y(2)','y(1)'),0,2*pi,[0,1]',100);

ne=size(f,1); %Dimension de la solucion
F=cell(ne,1); %Inicializa F
for i=1:ne
    F{i,1}=inline(f(i,:),'t','y'); %Crea una celula de funciones f(t,y)
end
h=(tfin-t0)/n; %Ancho del paso
tn=linspace(t0,tfin,n+1); %Vector tiempos
y=y0; %Asigna la condicion inicial como solucion en el instante tn
soln=ones(ne,n+1); %Inicializa el vector solucion
soln(:,1)=y; %Asigna la condicion con solucion en el tiempo inicial
for j=1:ne        
        Fin(j,1)=F{j}(tn(1),soln(:,1)); %Evalua f en en tn y yn
end
%soln(:,2)=y+h*Fin; %Para implementar salto de rana

Fvalor=zeros(ne,1); %Inicializa la evaluacion de f(t,y)

for i=1:n   
    for j=1:ne        
        Fvalor(j,1)=F{j}(tn(i),soln(:,i)); %Evalua f en en tn y yn
    end
    soln(:,i+1)=soln(:,i)+h*Fvalor;    
end


%%%%GRAFICAS%%%%
if ne==1
    title('Visualizacion del metodo de Euler')
    plot(t0,y0,'r.')
    hold on
    axis image
end

if nargin==6 && ne==1
    fplot(sol,[t0 tfin],'b')
end

if ne==1
    for i=1:n
        %axis([t0 tfin min(soln) max(soln)])
        pause
        plot([tn(i) tn(i+1)],[soln(i) soln(i+1)],'m.-');
                plot(tn(i+1),soln(i+1),'r.');
        axis image
        pause
    end
    close all
end 



%Optimizado
function [u,er]=ftcs(t0,tf,nt,a,b,nx,ci,cca,ccb,dif,cada,sol)
% function [u,er]=ftcs(t0,tf,nt,a,b,nx,ci,cca,ccb,dif,cada,sol)
% m�todo expl�cito para la ecuaci�n de calor del tipo: u_t=dif*u_x
% con condiciones iniciales:
% u(t,a)=cca(t)
% u(t,b)=ccb(t)
% u(0,x)=ci(x)
% t0: tiempo inicial
% tf: tiempo final
% nt: nodos de tiempo
% a,b: extemos de la barra
% nx: nodos espaciales


x=linspace(a,b,nx);  x=x';  dx=x(2)-x(1);
t=linspace(t0,tf,nt); t=t';  dt=t(2)-t(1);


%%%%%%Test de estabilidad%%%%%%
r=dt/dx^2*dif;   
if r>.5
    clc
    disp('No se cumple el test de estabilidad')
    disp(r)
    pause
end


di=1-2*r; %elementos de la diagonal
cca=inline(cca,'t');
ccb=inline(ccb,'t');
%%%%%%Matriz de coeficientes%%%%%%
A=diag(di*ones(nx-2,1))+diag(r*ones(nx-3,1),1)+diag(r*ones(nx-3,1),-1); %matriz A sin los tiempos inciales y finales
A=[[r;zeros(nx-3,1)] A [zeros(nx-3,1);r]]; %matriz A con los tiempos inciales y finales 
u=subs(ci,'x',x);      % vector con la soluci�n para t=0, es decir, condici�n inicial


%%%%%%Graficas%%%%%%




disp('Crando vector condicion inicial')
u(1)=cca(t(1));   % se cambia el extremo izquierdo por la condici�n de contorno izquierda
u(end)=ccb(t(1)); % idem para la condici�n de contorno derecha
u=double(u);
z=u;
disp('Empieza bucle')

    tic%%%%%%%%
for i=1:nt-1;  
    %disp('Multiplicando A por u')
    u=A*u;
    %disp('Redimensionando')
    u=[cca(t(i+1)); u ; ccb(t(i+1))];

%    if mod(i,cada)==0

%        set(gra,'ydata',double(u));
%        z(:,end+1)=u;
%    end

end
toc%%%%%%%% 

   disp('Empieza graficas')
    gra=plot(x,z(:,1),'erasemode','xor'); %Grafica de la condición incial
    axis([a b min(z(:,1)) max(z(:,1))])
    pause
for i=1:nt-1 %Muestra nueva distribución
    set(gra,'ydata',z(:,i)); 
end

%%%%%%Calcular error%%%%%%
%if nargin==12 & nargout==2
%    sol=vectorize(inline(sol,'x','t'));
%    er=u-sol(x,tf);
%end

%%%%%%Graficas%%%%%%
%pause
%figure
%surfc(double(z));shading interp; colormap(hot);set(gca,'ydir','reverse');
%rotate3d

    
    
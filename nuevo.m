function [u,E]=ftcs(t0,tf,nt,a,b,nx,ci,cca,ccb,dif,cada,sol,cicte,lamb)
% método explícito
x=linspace(a,b,nx);  x=x';  dx=x(2)-x(1);
t=linspace(t0,tf,nt); t=t';  dt=t(2)-t(1);
r=dt/dx^2*dif;  
if r>.5
    clc
    disp('No se cumple el test de estabilidad')
    pause
end
di=1-2*r;
cca=inline(cca,'t');
ccb=inline(ccb,'t');

%%%%%%%%%NUEVO CODIGO%%%%%%%%%
%a=[13.1*ones(25,1);130*ones(50,1);60*ones(50,1);13.1*ones(25,1)].*10^-6

lplus=.5*(lamb+circshift(lamb,[1,-1]));
lminus=.5*(lamb+circshift(lamb,[1,1]));
D=dt/(dx^2);

diagonal=diag(1-D*(lplus+lminus));
diaginf=D*diag(lplus,-1); diaginf=diaginf(2:end,2:end);
diagsup=D*diag(lminus,1); diagsup=diagsup(1:end-1,1:end-1);
A=diagonal+diaginf+diagsup;

%%ENERGIA
E=ones(nt,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%A=diag(di*ones(nx,1))+diag(r*ones(nx-1,1),1)+diag(r*ones(nx-1,1),-1);
A(1,1)=1; A(1,2)=0; 
A(nx,nx)=1; A(nx,nx-1)=0;

%u=subs(ci,'x',x);      % vector con la solución para t=0, es decir, condición inicial
ci=vectorize(inline(ci,'x'));
u=ci(x);
gra=plot(x,u,'erasemode','xor');
axis([a b min(u) max(u)])
pause
%z=u;
u(1)=cca(t(1));   % se cambia el extremo izquierdo por la condición de contorno izquierda
u(end)=ccb(t(1)); % idem para la condición de contorno derecha





if cicte==1
    u=A^nt*u;
    set(gra,'ydata',u);
end

if cicte==0
for i=1:nt-1;  
    u=A*u;
%disp('resta')
%tic
   sumar=(lamb').*((u-circshift(u,[1,1])).^2 );
%toc
%    disp('suma') 
%    tic

    suma=sum(sumar(2:nx));
%    toc
%    disp('asigna')
%    tic
    E(i,1)=1/(2*dx)* (suma);
%    toc

 % if mod(i,cada)==0
 %       set(gra,'ydata',u');
 %     %  z(:,end+1)=u;
 %   end
end
end
%if nargin==12 & nargout==2
%    sol=vectorize(inline(sol,'x','t'));
%    er=u-sol(x,tf);
%end

pause
close all
%figure
%surfc(z);shading interp; colormap(hot);set(gca,'ydir','reverse');
%rotate3d

    
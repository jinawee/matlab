function [u,er]=e_ondas(t0,tf,nt,a,b,nx,ci_f,ci_g,cca,ccb,gamma,cada,sol,yventana)

%[u,er]=e_ondas(t0,tf,nt,a,b,nx,ci_f,ci_g,cca,ccb,gamma,cada,sol,yventana)
%nt:numero tiempos
%nx:numero espacios
%Suponemos una ecuacion del tipo: u_tt=gamma^2*u_xx
%Las condiciones de contorno son:
%u(a,t)=cca(t)
%u(b,t)=ccb(t)
%u(x,t0)=ci_f(x)
%u_t(x,t0)=ci_g(x)
%Todas las funciones se introducen como tipo char
%yventana:l�mites del eje Y

clc
x=linspace(a,b,nx);  x=x';  dx=x(2)-x(1);
t=linspace(t0,tf,nt); t=t';  dt=t(2)-t(1);
lambda=gamma*dt/dx;  
if lambda>1
    disp('No se cumple el test de estabilidad')
    pause
end
lam2=lambda^2;
di=2*(1-lam2);
x=x(2:end-1);

f=vectorize(inline(ci_f, 'x'));
g=vectorize(inline(ci_g, 'x'));
cca=inline(cca,'t');
ccb=inline(ccb,'t');

A=diag(di*ones(nx-2,1))+diag(lam2*ones(nx-3,1),1)+diag(lam2*ones(nx-3,1),-1);

u0=f(x).*ones(nx-2,1);
u1=(1-lam2)*f(x)+lam2*(f(x+dx)+f(x-dx))/2+dt*g(x);
u1=u1.*ones(nx-2,1);

z=[cca(t0);u0;ccb(t0)];
gra=plot(x,u1,'m','erasemode','xor');
hold on
gra2=quiver(x,u1,u1-u1,u1-u0);
z(:,end+1)=[cca(t(2));u1;ccb(t(2))];
if nargin==14
    axis([a,b,yventana]);
else
    axis([a b -max(abs(u1)) max(abs(u1))])
end
pause
for i=2:nt-1;  
    u=A*u1-u0;
    u(1)=u(1)+lam2*cca(t(i+1));
    u(end)=u(end)+lam2*ccb(t(i+1));
    if mod(i,cada)==0
        set(gra,'ydata',u');
        z(:,end+1)=[cca(t(i+1));u;ccb(t(i+1))];
    end
    u0=u1;
    u1=u;
    
end
if nargin>12 && nargout==2
    sol=vectorize(inline(sol,'x','t'));
    er=u-sol(x,tf);
end

pause
figure
surfc(z);shading interp; colormap(jet);set(gca,'ydir','reverse');
rotate3d

pause
close all

    

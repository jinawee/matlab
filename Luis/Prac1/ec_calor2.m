function [A,u,q] = ec_calor2(t0,tf,nt,ci,cca,ccb,cada)

nx = 150;
x=linspace(0,1.5,nx);  x=x';  dx=x(2)-x(1);
t=linspace(t0,tf,nt); t=t';  dt=t(2)-t(1);

% Fuentes de calor
Q1 = inline('0*x','x');
Q2 = inline('0.4*exp(-((x-0.75)/0.15)^2)','x');
Q3 = inline('-0.3*exp(-((x-0.75)/0.15)^2)','x');
for i = 1:150
    q(i) = Q3(x(i))*dt;
end
q(1)=0; q(end)=0;
q = q.';

u=subs(ci,'x',x);
gra=plot(x,u,'erasemode','xor');
axis([0 1.5 0 1000])
pause

cca=inline(cca,'t');
ccb=inline(ccb,'t');

acero = 1.31e-5;
cobre = 1.3e-4;
aceropla = 6e-5;

r1 = acero*dt/dx^2;
r2 = cobre*dt/dx^2;
r3 = aceropla*dt/dx^2;

if r1>.5 || r2>.5 || r3>.5
    clc
    disp('No se cumple el test de estabilidad')
    pause
end

A = zeros(150,150);
A(1,1) = 1; A(150,150) = 1;
% Primera parte acero
for i = 2:24
        A(i,i-1:i+1) = [r1 1-2*r1 r1];
end
% Transición acero/cobre
A(25,24:26) = [ r1 1-(3/2*acero+1/2*cobre)*dt/dx^2  (acero+cobre)/2*dt/dx^2 ];
A(26,25:27) = [ (cobre+acero)/2*dt/dx^2 1-(3/2*cobre+1/2*acero)*dt/dx^2 r2 ];
% Parte cobre
for i = 27:74
    A(i,i-1:i+1) = [ r2 1-2*r2 r2];
end
% Transición cobre/acero plateado
A(75,74:76) = [ r2 1-(3/2*cobre+1/2*aceropla)*dt/dx^2  (aceropla+cobre)/2*dt/dx^2 ];
A(76,75:77) = [ (cobre+aceropla)/2*dt/dx^2 1-(3/2*aceropla+1/2*cobre)*dt/dx^2 r3];
% Parte acero plateado
for i = 77:124
    A(i,i-1:i+1) = [ r3 1-2*r3 r3];
end
% Transición acero plateado/acero
A(125,124:126) = [ r3 1-(3/2*aceropla+1/2*acero)*dt/dx^2  (aceropla+acero)/2*dt/dx^2 ];
A(126,125:127) = [ (acero+aceropla)/2*dt/dx^2 1-(3/2*acero+1/2*aceropla)*dt/dx^2 r1];
% Parte final acero
for i = 127:149
        A(i,i-1:i+1) = [r1 1-2*r1 r1];
end

u(1)=cca(t(1));
u(end)=ccb(t(1));

for i=1:nt-1;  
    u=A*u+q;
    if mod(i,cada)==0
        set(gra,'ydata',u');
    end
end
axis([0 1.5 min(u) max(u)])
pause
close all
end



    
function [u,er]=btcs(t0,tf,nt,a,b,nx,ci,cca,ccb,dif,cada,sol)
% método implícito
x=linspace(a,b,nx);  x=x';  dx=x(2)-x(1);  
t=linspace(t0,tf,nt); t=t';  dt=t(2)-t(1);
r=dt/dx^2*dif;  
cca=inline(cca,'t');
ccb=inline(ccb,'t');
di=1+2*r;
A=diag(di*ones(nx-2,1))+diag(-r*ones(nx-3,1),1)+diag(-r*ones(nx-3,1),-1);
A=inv(A);
% A=[[r;zeros(nx-3,1)] A [zeros(nx-3,1);r]];
u=subs(ci,'x',x);
gra=plot(x,u,'erasemode','xor');
axis([a b min(u) 1.05*max(u)])
pause
z=u;
u=u(2:end-1);
for i=1:nt-1;  
    u(1)=u(1)+r*cca(t(i));
    u(end)=u(end)+r*ccb(t(i));
    u=A*u;
    if mod(i,cada)==0
        xn=[cca(t(i+1));u;ccb(t(i+1))];
        set(gra,'ydata',xn);
        z(:,end+1)=xn;
    end  
end
u=[cca(tf);u;ccb(tf)];
if nargin==12
    sol=vectorize(inline(sol,'x','t'));
    er=u-sol(x,tf);
end

pause
figure
surfc(z);shading interp; colormap(hot);set(gca,'ydir','reverse');
rotate3d

    
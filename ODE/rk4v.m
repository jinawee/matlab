function [tnu,soln]=rk4v(f,t0,tfin,y0,n,sol)
% Sintaxis    [tn,soln]=eulerv(f,t0,tfin,y0,n,sol)
%
%  f     ecuacion diferencial (cada fila es una funcion componente)
%  t0    t inicial
%  tfin  t final
%  y0    condicion de Cauchy
%  n     numero de subintervalos
%  sol   solucion exacta para una variable (opcional)
%
%  tn    particion del intervalo  [to tfin]
%  soln  solucion numerica
ne=size(f,1);
for i=1:ne
    F(i,1)=sym(f(i,:));
end
h=(tfin-t0)/n;
hm=h/2;
hc=h/4;
tnu=linspace(t0,tfin,n+1);
y=y0;
soln=y;
if ne==1
    title('Visualizacion del metodo de Runge Kutta')
    plot(t0,y0,'r.')
    hold on
    axis image
end
for i=1:n
    t=tnu(i);
    k1=eval(F);
    
    t=t+hm ; y=soln(:,end)+hm*k1;  k2=eval(F);
    
             y=soln(:,end)+hm*k2;  k3=eval(F);
    
    t=t+hm ; y=soln(:,end)+h*k3;   k4=eval(F);
    
    
    t=tnu(i);
    y=soln(:,end);
    yn=soln(:,end)+h/6*(k1+k4+2*(k2+k3));
    if ne==1
        plot([t t+hc],[y y+hc*k1],'m');z(1)=text(t,y,'k1');pause,axis image
        plot([t+hm t+hm+hc],[y+hm*k1 y+hm*k1+hc*k2],'g');z(2)=text(t+hm,y+hm*k1,'k2');,axis image,pause
        plot([t+hm t+hm+hc],[y+hm*k2 y+hm*k2+hc*k3],'c');z(3)=text(t+hm,y+hm*k2,'k3');axis image,pause
        plot([t+h t+h+hc],[y+h*k3 y+h*k3+hc*k4],'r');z(4)=text(t+h,y+h*k3,'k4');axis image,pause  
        
        plot([t t+h],[y yn],'m.-');
        axis image
        pause
        set(z,'string','')
        pause
    end
    
    soln=[soln yn];
    y=yn;
    
    if nargin==6
        fplot(sol,[t t+h])
        axis image
    end
    
end

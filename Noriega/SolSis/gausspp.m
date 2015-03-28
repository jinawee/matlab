function [s,a]=gausspp(a,b)
n=length(b);
a=[a b];
%symbols;
 a=sym(a);
zz=colormap;
%t=zeros(n,n+1)
for i=1:n
    for j=1:n+1
        t(i,j)=text(j,-i,char(a(i,j)));
    end
end
axis([.9 n+2 -n-3 2])
set(gca,'xtick',[]);set(gca,'ytick',[]);
for i=1:n
    set(t(i,i),'color','r')
    title(['Busqueda del pivote ' num2str(i) ''],'color','c')
    set(t(i:n,i),'color','c')
    pause
    [va,lu]=max(abs(double(a(i:n,i))));lu=lu+i-1;
    if va==0
        clc;disp('se ha encontrado un pivote nulo');
        title(' El sistema es compatible e indeterminado o incompatible')
        s=[];
        return
    end
    set(t(lu,i),'color','m');
    title(['pivote en la fila ' num2str(lu) ''],'color','m');
    pause
    if lu~=i
        title(['Intercambiamos las filas ' num2str(i) ' y ' num2str(lu) ''],'color','r')
        pause
        set(t([i lu],i:n+1),'color','r');pause
        a([i lu],:)=a([lu i],:);
        zz=get(t(i,:),'string');
        for k=1:n+1; set(t(i,k),'string',get(t(lu,k),'string'));set(t(lu,k),'string',zz{k});end
    end
    set(t(:,:),'color','k');
    title ('Realizamos el proceso de Gauss');
    for j=i+1:n
        title(['proceso de la ',num2str(j), ' fila '],'color','b')
        set(t(j,i:n+1),'color','b')
        mul=a(j,i)/a(i,i);
        pause
        for k=i:n+1
            a(j,k)=a(j,k)-mul*a(i,k);
            set(t(j,k),'string',char(a(j,k))); 
           set(t(j,k),'color','r');pause
        end
        set(t(j,:),'color','k')
    end
end
title(' Proceso concluido','color','m')
% solucion del sistema
s(n,1)=a(n,n+1)/a(n,n);
for i=n-1:-1:1
    s(i,1)=(a(i,n+1)-a(i,i+1:n)*s(i+1:n,1))/a(i,i);
end
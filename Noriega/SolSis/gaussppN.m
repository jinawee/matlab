function [s,a]=gaussppN(a,b,N)
n=length(b);
a=[a b];
a=double(a);
a=vpa(a,N);
zz=colormap;
for i=1:n
    for j=1:n+1
        t(i,j)=text(j,-i,num2str(a(i,j)));
    end
end
axis([.9 n+2 -n-3 2])
set(gca,'xtick',[]);set(gca,'ytick',[]);
title([' Proceso de Gauss con aritmetica de ' num2str(N) ' digitos'],'color','b');
pause
for i=1:n
    set(t(i,i),'color','r')
    title(['Busqueda del pivote ' num2str(i) 'º'],'color','c')
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
    title(['pivote en la fila ' num2str(lu) 'ª'],'color','m');
    pause
    if lu~=i
        title(['Intercambiamos las filas ' num2str(i) 'ª y ' num2str(lu) 'ª'],'color','r')
        pause
        set(t([i lu],i:n+1),'color','r');pause
        a([i lu],:)=a([lu i],:);
        zz=get(t(i,:),'string');
        for k=1:n+1; set(t(i,k),'string',get(t(lu,k),'string'));set(t(lu,k),'string',zz{k});end
    end
    set(t(:,:),'color','k');
    title ('Realizamos el proceso de Gauss');
    for j=i+1:n
        title(['proceso de la ',num2str(j), 'ª fila '],'color','b')
        set(t(j,i:n+1),'color','b')
        mul=vpa(a(j,i)/a(i,i),N);
        pause
        for k=i:n+1
            a(j,k)=vpa(a(j,k)-mul*a(i,k),N);
            set(t(j,k),'string',num2str(a(j,k))); 
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
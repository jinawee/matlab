clear all;

n=[5 10 15 20 ];
f=@(x)exp(-x.^-2);
x=linspace(-3/2,3/2,100);

for i=1:length(n)                   %Tiene que redibujar las mismas graficas, lo cual no es eficiente
    xeq=linspace(-3/2,3/2,n(i));    %Las gráficas se podrían realizar en otro bucle para mejorar la fluidez
    xc=cheby(n(i))*3/2;
    
    hold on  
    axis([-3/2 3/2 0 1])
    axis manual
    plot(x,f(x),'k')
    title(['n=' num2str(n(i))])
    plot(xeq,f(xeq),'ro');
    plot(xc,f(xc),'go'); 
    
    peq{i}=matlabFunction( ifn(xeq,f(xeq)) );
    pch{i}=matlabFunction( ifn(xc,f(xc)) );
    
    plot(x,peq{i}(x),'r')
    plot(x,pch{i}(x),'g')
    pause;
    clf
end
close all
clear all;

n=[31];
f=@(x)exp(-x.^-2);
x=linspace(-3/2,3/2,100);

for i=1:length(n)                  
    xeq=linspace(-3/2,3/2,n(i))   
    xc=cheby(n(i))*3/2
    length(xeq)
    length(xc)
    hold on  
    axis([-3/2 3/2 0 1])
    axis manual
    plot(x,f(x),'k')
    title(['n=' num2str(n(i))])
    peq{i}=matlabFunction( ifn(xeq,f(xeq)) );
    pch{i}=matlabFunction( ifn(xc,f(xc)) );
    plot(x,peq{i}(x),'r')
    plot(x,pch{i}(x),'g')
    legend('Valor exacto','Nodos equiespaciados','Nodos de Chebyshev')

    plot(xeq,f(xeq),'ro');
    plot(xc,f(xc),'go'); 
    

    pause;
    clf
end
close all
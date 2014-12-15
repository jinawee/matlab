function runge
%f=inline('abs(x)')
%f=inline('1./(1+x.^2)')
f=inline('sin(1./x)')

fplot( f ,[-1 1])
hold on
for i=20:5:25
    eq=linspace(-5,5,i) ;
    x=cheby(i);
    y=f(x) ; 
    yeq=f(eq);
    p=inline(ifn(x,y));
    peq=inline(ifn(eq,yeq));
    plot(x,p(x),'g');
    plot(eq,peq(eq),'r');
    pause
end
close all

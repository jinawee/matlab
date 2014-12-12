function runge
%f=inline('abs(x)')
%f=inline('1./(1+x.^2)')
f=inline('sin(1./x)')

fplot( f ,[-5 5])
hold on
for i=6:2:16 , 
    %x=linspace(-5,5,i) ;
    x=cheby(i)*5 ;
    y=f(x) ; 
    p=ifn(x,y,1)  
    pause
end

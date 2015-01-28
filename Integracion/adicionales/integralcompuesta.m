function integral = integralcompuesta(a,b,f,n)

%n>=2
f=inline(f);
x=linspace(a,b,n);

integral=0;
h=x(2)-x(1);

for i=1:(n-1)
    integral = h/4 * ( f(x(i)) + 3*f(x(i)+2/3*h ) )  + integral; 
end
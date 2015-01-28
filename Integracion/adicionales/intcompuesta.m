function integral=intcompuesta(f,a,b,n)

%Solo funciona para n>=2

f=vectorize(inline(f));

x=linspace(a,b,n);

h=(b-a)/(n-1);

integral=h/4 * sum( f(x(1:n-1)) + 3*f(x(1:n-1) + 2/3*h) );
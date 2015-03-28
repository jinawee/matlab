function [xvec,nit] = regulafalsi(f,a,b,nmax,tol)
%Ejemplo: [x,n]=regulafalsi('cos(x)', 0, 3 ,1000,1e-8)
f=inline(f);
%f=['@(x)' f];

if f(a)*f(b)>0
    disp('No hay cambio de signo en los extremos del intervalo, introduzca una función que cambie de signo en sus extremos, por favor.')
    xvec=[];
    return 
end

if f(a)==0
    disp('Raíz exacta encontrada en el extremo del intervalo izquierdo')
    xvec=a;
    return
end

if f(b)==0
    disp('Raíz exacta encontrada en el extremo del intervalo derecho')
    xvec=b;
    return    
end

%xn=zeros(1,nmax);
for nit=1:nmax %Comienzan las iteraciones
    fa=f(a); fb=f(b);
    alfa=(fb-fa)/(b-a);
    xn(nit)=b-fb/alfa;
    fxn=f(xn(nit));
    if fxn==0
        disp(['Raíz exacta encontrada en ' ,num2str(xn(nit))]);
        xvec=xn(nit);  
        return
    end
    if abs(b-xn(nit))<tol || abs(a-xn(nit))<tol
     break;
    end
    if fa*fxn<0
        b=xn(nit);
    else
        a=xn(nit);
    end

end    

xvec=xn; 

function x=biseccion(f,v,n)
%f: cadena de caracteres de la funcionç
%v: vector del intervalo donde se buscan las raices, v=[a,b]
%n: si n>=1 nº de iteraciones, si n<1 tolerancia
%x: aproximacion a la raiz

f=inline(f);
a=v(1); b=v(2);

if f(a)*f(b)>0
    disp('No hay cambio de signo en los extremos del intervalo, introduzca una función que cambie de signo en sus extremos, por favor.')
    x=[];
    return 
end

if f(a)==0
    disp('Raíz exacta encontrada en el extremo del intervalo izquierdo')
    x=a;
    return
end

if f(b)==0
    disp('Raíz exacta encontrada en el extremo del intervalo derecho')
    x=b;
    return    
end

if n<1 %Fijamos el numero de iteraciones o la tolerancia?
    n=ceil(log2((b-a)/n));
end

for i=1:n %Comienzan las iteraciones
    ptmed=(a+b)/2;
    if f(ptmed)==0
        disp(['Raíz exacta encontrada en ' ,num2str(ptmed)]);
        x=ptmed;  
        return
    end
    if f(a)*f(ptmed)<0
        b=ptmed;
    else
        a=ptmed;
    end
end    
   
x=ptmed; 


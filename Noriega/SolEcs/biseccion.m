function x=biseccion(f,v,n)
%f: cadena de caracteres de la funcion�
%v: vector del intervalo donde se buscan las raices, v=[a,b]
%n: si n>=1 n� de iteraciones, si n<1 tolerancia
%x: aproximacion a la raiz

f=['@(x)' f];
a=v(1); b=v(2);

if f(a)*f(b)>0
    disp('No hay cambio de signo en los extremos del intervalo, introduzca una funci�n que cambie de signo en sus extremos, por favor.')
    x=[];
    return 
end

if f(a)==0
    disp('Ra�z exacta encontrada en el extremo del intervalo izquierdo')
    x=a;
    return
end

if f(b)==0
    disp('Ra�z exacta encontrada en el extremo del intervalo derecho')
    x=b;
    return    
end

if n<1 %Fijamos el numero de iteraciones o la tolerancia?
    n=ceil(log2((b-a)/n));
end

fa=f(a);
for i=1:n %Comienzan las iteraciones
    ptmed=(a+b)/2;
    fptmed=f(ptmed);
    if fptmed==0
        disp(['Ra�z exacta encontrada en ' ,num2str(ptmed)]);
        x=ptmed;  
        return
    end
    if fa*fptmed<0
        b=ptmed;
    else
        a=ptmed;
    end
end    
   
x=ptmed; 


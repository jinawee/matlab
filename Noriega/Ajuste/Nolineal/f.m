function y = f(c,x)
% f(x)= c(1).x   para   x  en   [0  c(2)]
% f(x)= c(1).c(2)+c(3).atan(c(1)/c(3).(x-c(2))) para x en [c(2),inf]
% 
n=length(x);
for i=1:n
    if x(i) < c(2)
        % definicion de   f   en  [0  c(2)]
        y(i) = c(1)*x(i);
    else
        % definicion de   f   en  [c(2) inf]
        y(i) = c(1)*c(2) + c(3) * atan(c(1)/c(3) * (x(i)-c(2)));
    end
end    

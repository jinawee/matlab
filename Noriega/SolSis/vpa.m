function y=vpa(x,n)
if nargin==1
    n=4;
end
y=floor(x*10^n)/10^n;
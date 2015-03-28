function z=mp(a,z,nit)
n=length(a);
if n==2
    t=linspace(0,2*pi,300);
    plot(cos(t),sin(t));
    axis image
    hold on
    vector=plot([0 z(1)],[0 z(2)],'r');
    pause
end

for i=1:nit
    z=a*z;
    if n==2
        set(vector,'xdata',[0 z(1)],'ydata',[0 z(2)]);
        axis image
        title(num2str(z'));
        pause
    end
    z=z/norm(z);
end
        
        
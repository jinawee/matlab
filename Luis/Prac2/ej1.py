from numpy import *
from matplotlib.pyplot import *
from time import time

lo=632.8e-9;
c=3e8;      
tau=lo/c;   

paso=30;
t0=20*tau;  
sigma=2*tau;
J=lambda t:exp(-0.5*((t-t0)/sigma)**2)
dz=lo/10;       
dt=dz/(2*c);    
nz=2000; nt=1000
t=0;            
z=dz*(arange(1,nz+1))*1e6;
E=zeros(nz); H=zeros(nz);

zf=nz*dz*1e6;
g,=plot(z,E,lw=2)
show(block=False)
axis([0,zf,-1,1]);

#for n in range(nt):
#    for i in range(1,nz-1):
#
#    E[nz/2]=E[nz/2]+J(t);
#    
#    for i in range(1,nz-1): 
#E,H=loop(t0,sigma)

file_handle = open('datos', 'r')
lines_list = file_handle.readlines()
#cols, rows = (int(val) for val in lines_list[0].split())
# Do a double-nested list comprehension to get the rest of the data into your matrix
my_data = [[val for val in line.split()] for line in lines_list[1:]]
print shape(my_data)

with open('datos') as f:
    w, h = [float(x) for x in f.readline().split()]
    array = [[float(x) for x in line.split()] for line in f]

for n in range(nt):
  if not n%paso:
    #clf()
    plot(z,E)
    g.set_data(z,E)

    #axis([0,zf,-1,1]);
    draw()
    #xlabel('z(micras)')

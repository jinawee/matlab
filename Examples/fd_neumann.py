# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-
"""
Created on Sun Jan 27 15:12:21 2013

@author: greg
"""

import sys
import numpy as np
import matplotlib.pyplot as plt
from scipy.sparse import spdiags
from scipy.sparse.linalg import spsolve
from sympy import diff, lambdify, exp, sin
from sympy.abc import u,x


def fd_neumann(n,f,a,b,method):
    """ Solve the two-point boundary value problem -u''(x)=f(x)
    on [0,1] with u'(0)=a and u(1)=b on n+1 grid points """
        
    h = 1.0/n                                  # Grid spacing

    xi = np.linspace(0,1,n+1)                  # Grid points
        
    rhs = h**2*f(xi[:-1])                      # Evaluate forcing function
    rhs[-1] += b                               # Dirichlet data
         
    if method == 1:                            # first-order symmetric
        rhs[0] = -h*a 
        
        stencil = np.array((-1, 2, -1))        # Approx for 2nd derivative      
        diags = range(-1,2)                    # Offsets of diags [-1,0,1]
        bands = np.tile(stencil,(n,1)).T       # Default bands
        bands[1,0] *= 0.5                      # Modify for Neumman 
                
            
    elif method == 2:                          # second-order nonsymmetric
        rhs[0] = -2*h*a 

        stencil = np.array((-1, 2, -1, 0))     # Approx for 2nd derivative      
        diags = range(-1,3)                    # Offsets of diags [-1,0,1,2]
        bands = np.tile(stencil,(n,1)).T       # Default bands
        bands[1,0] = 3                         # one-sided differences
        bands[2,1] = -4
        bands[3,2] = 1
        
                    
    elif method == 3:                          # second-order symmetric            
        rhs[0] *= 0.5
        rhs[0] -= h*a 

        stencil = np.array((-1, 2, -1))        # Approx for 2nd derivative      
        diags = range(-1,2)                    # Offsets of diags [-1,0,1]
        bands = np.tile(stencil,(n,1)).T       # Default bands
        bands[1,0] *= 0.5                      # Modify for Neumman 


    A = spdiags(bands,diags,n,n).tocsc()       # Form sparse matrix
            
    u = np.zeros(n+1)
    u[-1] = b                                  # set boundary value
    u[:-1] = spsolve(A,rhs)
        
    return xi, u
        
        
        
if __name__ == '__main__':
    
    #n = int(sys.argv[1])       # Number of unknowns
    n = 200
    xi = np.linspace(0,1,n+1)   # Grid points 
    
    u = exp(x)/(1+x)            # Manufactured solution to test methods
    ux = diff(u,x)              # First derivative
    uxx = diff(ux,x)            # Second derivative
    f = -uxx                    # Forcing function
    
    U = lambdify(x,u,"numpy")   # make u a callable function 
    Ux = lambdify(x,ux,"numpy") # make ux a callable function
    F = lambdify(x,f,"numpy")   # make f a callable function
    
    a = Ux(0)                   # Neumann boundary value
    
    b = U(1)                    # Dirichlet boundary value

    # Compute solution with all three methods
    xi,u1 = fd_neumann(n,F,a,b,1) 
    xi,u2 = fd_neumann(n,F,a,b,2) 
    xi,u3 = fd_neumann(n,F,a,b,3) 
    
    # Compute error for each approximation
    uex = U(xi)    # Evaluate exact solution
    e1 = uex-u1
    e2 = uex-u2
    e3 = uex-u3
    
#    print 'h = ', 1.0/n
#    print 'The max error of method 1 is:', max(abs(e1))
#    print 'The max error of method 2 is:', max(abs(e2))
#    print 'The max error of method 3 is:', max(abs(e3))
#    
#    plt.plot(xi,e1,xi,e2,xi,e3)
    plt.plot(xi,u1)
    plt.show()


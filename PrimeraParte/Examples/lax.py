from __future__ import division
from scipy.sparse import spdiags
from scipy.sparse.linalg import spsolve
import numpy as np
import pylab

def make_advection_matrices(z, r):
    """Return matrices A and M for advection equations"""
    ones = np.ones(len(z))
    A = spdiags( [-beta*r, ones, beta*r], (-1,0,1), len(z), len(z) )
    M = spdiags( [(1-beta) * r, ones, -(1-beta) * r], (-1,0,1), len(z), len(z) )
    return A.tocsr(), M.tocsr()

def plot_iteration(z, u, iteration):
    """Plot the solver progress"""
    pylab.plot(z, u, label="Iteration %d" % iteration)

# Set up basic constants
beta = 0.5
J = 200 # total number of mesh points
z = np.linspace(-10,10,J) # vertices
dz = abs(z[1]-z[0]) # space step
dt = 0.001    # time step
v = 2 * np.ones(len(z)) # velocity field (constant)
r = v / 2 * dt / dz

# Initial conditions (peak function)
gaussian = lambda z, height, position, hwhm: height * np.exp(-np.log(2) * ((z - position)/hwhm)**2)
u_init = gaussian(z, 1, -3, 2)

A, M = make_advection_matrices(z, r)
u = u_init
for i in range(100000):
    u = spsolve(A, M * u)
    if not i%100000:
        print i
        plot_iteration(z, u, i)

pylab.legend()
pylab.show()

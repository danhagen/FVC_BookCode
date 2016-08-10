import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
import itertools
from scipy.spatial import ConvexHull
from mpl_toolkits.mplot3d import Axes3D
def quick_2D_plot_tool(xlabel,ylabel,title,axes_position):
	"""
	This will take in the x and y labels as well as a figure title and
	format an already established figure to remove the box, place the
	tick marks outwards, and set aspect ratio to equal.
	"""
	ax = plt.gca()
	ax.spines['left'].set_position('zero')
	ax.spines['right'].set_color('none')
	ax.spines['bottom'].set_position('zero')
	ax.spines['top'].set_color('none')
	ax.xaxis.set_ticks_position('bottom')
	ax.yaxis.set_ticks_position('left')
	ax.set_xlabel(xlabel)
	ax.set_ylabel(ylabel)
	ax.set_title(title)
	ax.set_aspect('equal', 'datalim')
def MuscleForceMatrix(fmax):
	"""
	Takes in an array of  n muscle forces and returns an n x n matrix
	of the muscle forces on the diagonals
	"""
	n = len(fmax)
	F = np.matrix(np.identity(n)*fmax)
	return(F)
def MomentArmMatrix(r11,r12,r13,r21,r22,r23):
	R = np.matrix([	[r11, r12, r13],\
					[r21, r22, r23] ])
	return(R)
def JacobianMatrix(Angle1,Angle2,Link1,Link2):
	"""
	Utilizes symbolics to create a Jacobian matrix and its inverse
	transpose. Only appropriate for a 2 link planar model.
	"""
	Theta1, Theta2 = sp.symbols('Theta1 Theta2', real = True)
	G = sp.Matrix([	Link1*sp.cos(Theta1)+Link2*sp.cos(Theta1+Theta2),\
					Link1*sp.sin(Theta1)+Link2*sp.sin(Theta1+Theta2)	])
	J = G.jacobian([Theta1,Theta2])
	J_inv_trans = (J**-1).T
	J = J.subs([(Theta1,Angle1),(Theta2,Angle2)])
	J_inv_trans = J_inv_trans.subs([(Theta1,Angle1),(Theta2,Angle2)])
	return(J,J_inv_trans)

F = MuscleForceMatrix([350,700,525])
R = MomentArmMatrix(2,1,-1,1.5,-1.5,0)
J,J_inv_trans = JacobianMatrix(0,np.pi/4,1,1)
H = (J**-1).T*R*F

def GenerateActivationSpaceVertices(dim):
	"""
	This function takes the place of the Matlab function ncube.m.
	Takes in a dimension (dim) and gives all of the vertices needed 
	for a Minkowski sum.
	"""
	output = np.matrix(list(itertools.product([0, 1], repeat=dim))).T
	return(output)

a = GenerateActivationSpaceVertices(3)
WrenchVertices = np.array((H*a).T)
WrenchHull = ConvexHull(WrenchVertices)

def Plot2DConvHull(Vertices,Hull,Matrix,xlabel,ylabel,title):
	plt.figure()
	plt.plot(Vertices[:,0],Vertices[:,1],'ko')
	VectorArray = np.array([[0,0,float(Matrix[0,i]),float(Matrix[1,i])] for i in range(Matrix.shape[1])])
	X,Y,U,V = zip(*VectorArray)
	quick_2D_plot_tool(xlabel,ylabel,title)
	ax = plt.gca()
	ax.quiver(X,Y,U,V,\
				edgecolor='r', facecolor='r', \
				angles='xy',scale_units='xy',scale=1)
	plt.draw()
	for simplex in Hull.simplices:
	    plt.plot(Vertices[simplex,0],Vertices[simplex,1], color = 'grey')
	plt.show()

Plot2DConvHull(WrenchVertices,WrenchHull,H,'Force in x','Force in y','Feasible Force Set')

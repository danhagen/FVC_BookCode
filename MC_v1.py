import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
import itertools
from scipy.spatial import ConvexHull
from mpl_toolkits.mplot3d import Axes3D

"""
# Define variables for 3 muscles and 2 joints as in Fig 7.1
Angle1, Angle2 = sp.symbols('Angle1 Angle2', real = True)
Link1, Link2 = sp.symbols('Link1 Link2', real = True)
a1, a2, a3 = sp.symbols('a1 a2 a3', real = True)
r11, r12, r13 = sp.symbols('r11 r12 r13', real = True)
r21, r22, r23 = sp.symbols('r21 r22 r23', real = True)
f1max, f2max, f3max = sp.symbols('f1max f2max f3max', real = True)

A = sp.Matrix([a1,a2,a3])
F = sp.Matrix([	[f1max,		0,		0		],\
				[0,			f2max,	0		],\
				[0,			0,		f3max	] ])
R = sp.Matrix([	[r11, r12, r13],\
				[r21, r22, r23] ])
G = sp.Matrix([	Link1*sp.cos(Angle1)+Link2*sp.cos(Angle1+Angle2),\
				Link1*sp.sin(Angle1)+Link2*sp.sin(Angle1+Angle2)	])
J = G.jacobian([Angle1,Angle2])
H = (J**-1).T*R*F

print(A)
print(F)
print(R)
print((J**-1).T)
print(H)
"""

def MuscleForceMatrix(fmax1,fmax2,fmax3):
	F = np.matrix([	[fmax1,		0,			0		],\
					[0,			fmax2,		0		],\
					[0,			0,			fmax3	]	])
	return(F)

def MomentArmMatrix(r11,r12,r13,r21,r22,r23):
	R = np.matrix([	[r11, r12, r13],\
					[r21, r22, r23] ])
	return(R)

def JacobianMatrix(Angle1,Angle2,Link1,Link2):
	Theta1, Theta2 = sp.symbols('Theta1 Theta2', real = True)
	G = sp.Matrix([	Link1*sp.cos(Theta1)+Link2*sp.cos(Theta1+Theta2),\
					Link1*sp.sin(Theta1)+Link2*sp.sin(Theta1+Theta2)	])
	J = G.jacobian([Theta1,Theta2])
	J_inv_trans = (J**-1).T
	J = J.subs([(Theta1,Angle1),(Theta2,Angle2)])
	J_inv_trans = J_inv_trans.subs([(Theta1,Angle1),(Theta2,Angle2)])
	return(J,J_inv_trans)

F = MuscleForceMatrix(350,700,525)
R = MomentArmMatrix(2,1,-1,1.5,-1.5,0)
J,J_inv_trans = JacobianMatrix(0,np.pi/4,1,1)
H = (J**-1).T*R*F

def GenerateActivationSpaceVertices(dim):
	output = np.matrix(list(itertools.product([0, 1], repeat=dim))).T
	return(output)

a = GenerateActivationSpaceVertices(3)
WrenchVertices = np.array((H*a).T)
WrenchHull = ConvexHull(WrenchVertices)

def Plot2DConvHull(Vertices,Hull,Matrix):
	plt.figure()
	plt.plot(Vertices[:,0],Vertices[:,1],'ko')
	VectorArray =np.array([ [0,0,float(Matrix[0,0]),float(Matrix[1,0])], \
					[0,0,float(Matrix[0,1]),float(Matrix[1,1])], \
					[0,0,float(Matrix[0,2]),float(Matrix[1,2])]]) 
	X,Y,U,V = zip(*VectorArray)
	ax = plt.gca()
	ax.quiver(X,Y,U,V,\
				edgecolor='r', facecolor='r', \
				angles='xy',scale_units='xy',scale=1)
	plt.draw()
	plt.grid()
	for simplex in Hull.simplices:
	    plt.plot(Vertices[simplex,0],Vertices[simplex,1],'k-')
	plt.show()
"""
def Plot2DConvHull(Vertices,Hull,Matrix):
	fig = plt.figure()
	ax = fig.gca(projection='3d')
	ax.plot(Vertices[:,0],Vertices[:,1],Vertices[:,2],'ko')
	VectorArray =np.array([ [0,0,0,float(Matrix[0,0]),float(Matrix[1,0]),float(Matrix[2,0])], \
					[0,0,0,float(Matrix[0,1]),float(Matrix[1,1]),float(Matrix[2,1])], \
					[0,0,0,float(Matrix[0,2]),float(Matrix[1,2]),float(Matrix[2,2])]]) 
	plt.grid()
	for simplex in Hull.simplices:
	    ax.plot(Vertices[simplex,0],Vertices[simplex,1],Vertices[simplex,2],'k-')
	plt.show()
"""
Plot2DConvHull(WrenchVertices,WrenchHull,H)

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%%%%%%%% NEUROMECHANICS  %%%%%%%%%%%%%
# (c) Daniel A Hagen
# August 2016, version 1.0
# Filename: J3D3DOF.m
# Jacobian of 3D, 3DOF linkage syste#

import numpy as np
import sympy as sp
from numpy import pi 
import matplotlib.pyplot as plt 

# Define the symbolic variables for Fig 3.3
angle1, angle2, angle3 = sp.symbols('angle1 angle2 angle3', real = True)
link1, link2, link3 = sp.symbols('link1 link2 link3', real = True)

# Define Transformation Matrices from initial frame (T0) to endpoint frame (T3)
T0 = sp.Matrix([[sp.cos(angle1),	-sp.sin(angle1),	0,		0],\
				[sp.sin(angle1),	sp.cos(angle1),		0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])
T1 = sp.Matrix([[sp.cos(angle2),	-sp.sin(angle2),	0,		link1],\
				[sp.sin(angle2),	sp.cos(angle2),		0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])
T2 = sp.Matrix([[sp.cos(angle3),	-sp.sin(angle3),	0,		link2],\
				[sp.sin(angle3),	sp.cos(angle3),		0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])
T3 = sp.Matrix([[1,					0,					0,		link3],\
				[0,					1,					0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])

# Total Transformation
T = T0*T1*T2*T3

# Define Geometric Model to be the first two components (x,y) of the position
# vector of the Transformation Matrix (T) and the sum of all angles.
G =sp.Matrix([sp.simplify(T[0,3]),sp.simplify(T[1,3]), angle1+angle2+angle3])

# Calculate the Jacobian Matrix
J = G.jacobian([angle1,angle2,angle3])

#Calculate the Jacobian Matrix permutations
J_inv = J**-1
J_trans = J.T
J_inv_transpose = (J_inv).T

print("G\n",G,"\n")
print("J\n",J,"\n")
print("J Inverse\n",J_inv,"\n")
print("J Transpose\n",J_trans,"\n")
print("J Inverse Transpose\n",J_inv_transpose,"\n")

# Numerical Examples
# Define link lengths and joint angles
Link1, Link2, Link3 = 1, 1, 1
Angle1, Angle2, Angle3 = 0, pi/4, pi/4 # (0, 45, 45) degrees

# Define Substitution List
Subs = [(angle1, Angle1), (angle2, Angle2), (angle3, Angle3),\
		(link1, Link1), (link2, Link2), (link3, Link3)]

print("Evaluate the functions for these parameters:\n")
print("G:\n",G.subs(Subs),"\n")
print("J:\n",J.subs(Subs),"\n")
print("J Inverse:\n",J_inv.subs(Subs),"\n")
print("J Transpose:\n",J_trans.subs(Subs),"\n")
print("J Inverse Transpose:\n",J_inv_transpose.subs(Subs),"\n")

import sympy as sp 

# Define the symbolic variables for Fig 3.3
Angle1, Angle2, Angle3 = sp.symbols('Angle1 Angle2 Angle3', real = True)
Link1, Link2, Link3 = sp.symbols('Link1 Link2 Link3', real = True)

# Define Transformation Matrices from initial frame (T0) to endpoint frame (T3)
T0 = sp.Matrix([[sp.cos(Angle1),	-sp.sin(Angle1),	0,		0],\
				[sp.sin(Angle1),	sp.cos(Angle1),		0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])
T1 = sp.Matrix([[sp.cos(Angle2),	-sp.sin(Angle2),	0,		Link1],\
				[sp.sin(Angle2),	sp.cos(Angle2),		0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])
T2 = sp.Matrix([[sp.cos(Angle3),	-sp.sin(Angle3),	0,		Link2],\
				[sp.sin(Angle3),	sp.cos(Angle3),		0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])
T3 = sp.Matrix([[1,					0,					0,		Link3],\
				[0,					1,					0,		0],\
				[0,					0,					1,		0],\
				[0,					0,					0,		1]])

# Total Transformation
T = T0*T1*T2*T3

# Define Geometric Model to be the first two components (x,y) of the position
# vector of the Transformation Matrix (T) and the sum of all angles.
G =sp.Matrix([sp.simplify(T[0,3]),sp.simplify(T[1,3]), Angle1+Angle2+Angle3])

# Calculate the Jacobian Matrix
J = G.jacobian([Angle1,Angle2,Angle3])

#Calculate the Inverse Transpose Jacobian Matrix
J_inv_transpose = (J**-1).T

print(J_inv_transpose)

# Remove '#' to test for posture (0,45,45) and link lengths (1,1,1)

from numpy import pi 
J_inv_transpose = J_inv_transpose.subs([(Angle1, 0*pi/180),(Angle2, 45*pi/180), (Angle3, 45*pi/180), \
										(Link1, 1), (Link2, 1), (Link3,1)])
print(J_inv_transpose)
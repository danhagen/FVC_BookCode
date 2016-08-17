#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%%%%%%%% NEUROMECHANICS  %%%%%%%%%%%%%
# (c) Daniel A Hagen
# August 2016, version 1.0
# Filename: simple_forward_kinematics.m
# Forward Kinematics for Fig 2.1

import numpy as np 
import sympy as sp
import matplotlib.pyplot as plt 

def quick_2D_plot_tool(ax,xlabel,ylabel,title):
	"""
	This will take in the x and y labels as well as a figure title and
	format an already established figure to remove the box, place the
	tick marks outwards, and set aspect ratio to equal.
	"""
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

# Define the symbolic variables for Fig 3.3
angle1, angle2 = sp.symbols('angle1 angle2', real = True)
link1, link2 = sp.symbols('link1 link2', real = True)

# Define Transformation Matrices from initial frame (T0) to endpoint frame (T3)
T01 = sp.Matrix([	[sp.cos(angle1),	-sp.sin(angle1),	0,		0],\
					[sp.sin(angle1),	sp.cos(angle1),		0,		0],\
					[0,					0,					1,		0],\
					[0,					0,					0,		1]	])
T12 = sp.Matrix([	[sp.cos(angle2),	-sp.sin(angle2),	0,		link1],\
					[sp.sin(angle2),	sp.cos(angle2),		0,		0],\
					[0,					0,					1,		0],\
					[0,					0,					0,		1]	])
T23 = sp.Matrix([	[1,					0,					0,		link2],\
					[0,					1,					0,		0],\
					[0,					0,					1,		0],\
					[0,					0,					0,		1]	])

# Total Transformation
T = T01*T12*T23

# Define Geometric Model to be the first two components (x,y) of the position
# vector of the Transformation Matrix (T) and the sum of all angles.
G =sp.Matrix([sp.simplify(T[0,3]),sp.simplify(T[1,3]), angle1+angle2])
print("Position vector p from frame 0 to 3 (Our Geometric Model):\n", G, "\n")

# Numerical Example and plot for Angle 1 = 135 deg, Angle 2 = -120 deg
Angle1 = 135*np.pi/180
Angle2 = -120*np.pi/180

Link1 = 25.4 # cm
Link2 = 30.5 # cm

Subs = [(angle1, Angle1), (angle2, Angle2), (link1, Link1), (link2, Link2)]
[x,y,alpha] = G.subs(Subs)
print("G:\n",np.array(G.subs(Subs).T)[0],"\n")

def plot_configuration(ax,Angle1,Angle2,Link1,Link2):
	x = np.cumsum([0, Link1*np.cos(Angle1), Link2*np.cos(Angle1+Angle2)])
	y = np.cumsum([0, Link1*np.sin(Angle1), Link2*np.sin(Angle1+Angle2)])
	ax.plot(x,y,'ko-', markersize = 16, lw = 4)
	quick_2D_plot_tool(ax,'x','y','Simple Forward Kinematics for Fig 2.1 (Angle 1 = ' + '{0:.2f}'.format(Angle1*180/np.pi) + \
						', Angle 2 = ' + '{0:.2f}'.format(Angle2*180/np.pi) + ')')
plt.figure()
ax = plt.gca()
plot_configuration(ax, Angle1, Angle2, Link1, Link2)
plt.show(ax)
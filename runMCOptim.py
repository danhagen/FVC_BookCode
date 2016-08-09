import numpy as np
from matplotlib import cm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import random
from scipy.optimize import fmin_cobyla

# Define the equal ranges for variables X and Y
upper_bound = 10
lower_bound = -10
x_upper_bound = upper_bound
x_lower_bound = lower_bound
y_upper_bound = upper_bound
y_lower_bound = lower_bound

# Create the terrain for the function to be optimized
# that represents a very rough terrain
xx = np.arange(x_lower_bound,x_upper_bound,0.1)
yy = np.arange(y_lower_bound,y_upper_bound,0.1)
X,Y = np.meshgrid(xx,yy,sparse = True)
def func(x):
	R = np.sqrt(x[0]**2 + x[1]**2) + 1.5*np.sin(2*x[0]) + 2*np.cos(3*x[1]) + np.spacing(1)
	Z = np.sin(R)/R + 0.1*x[0] + 0.005*x[1]
	return(Z)
Z = func(np.array([X,Y])) 

# Show the terrain in Figure 1
def PlotSurface(X,Y,Z):
	figure_1 = plt.figure()
	axes_1 = figure_1.gca(projection='3d')
	surface_1 = axes_1.plot_surface(X, Y, Z, rstride=2, cstride=2, cmap=cm.jet,
	                       linewidth = 0, antialiased=False)
	axes_1.set_xlim([-10,10])
	axes_1.set_ylim([-10,10])
	axes_1.set_zlim([-1.5,2])
	axes_1.view_init(30,-120)
	axes_1.set_xlabel('x')
	axes_1.set_ylabel('y')
	axes_1.set_zlabel('z')
	plt.show(block=True)

#PlotSurface(X,Y,Z)

# Sample n random values of X and Y
n = 10**1

# SETTING SEED HERE, so that each time you run this you
# get a different set of random numbers
random.seed()

x_random = [random.uniform(x_lower_bound,x_upper_bound) for i in range(n)]
y_random = [random.uniform(y_lower_bound,y_upper_bound) for i in range(n)]

# Plot the resulting histograms for the random numbers
def PlotHistogram(X,bins):
	fig = plt.figure()
	# the histogram of the data
	plt.hist(X,bins, normed=1, facecolor='green', alpha=0.75)
	plt.ylabel('Frequency')
	plt.show()

#PlotHistogram(x_random,5)
#PlotHistogram(y_random,5)

# Run Optimization with scipy.optimize.fmin_cobyla
def func_to_maximize(x):
	R = np.sqrt(x[0]**2 + x[1]**2) + 1.5*np.sin(2*x[0]) + 2*np.cos(3*x[1]) + np.spacing(1)
	Z = -(np.sin(R)/R + 0.1*x[0] + 0.005*x[1])
	return(Z)
def constraint_1(x):
	return x[1]+10
def constraint_2(x):
	return 10-x[1]
def constraint_3(x):
	return x[0]+10
def constraint_4(x):
	return 10-x[0]
optimal_solutions = [fmin_cobyla(func_to_maximize,[x_random[i],y_random[i]],\
						[constraint_1, constraint_2, constraint_3, constraint_4]) \
						for i in range(n)]

def PlotSurfaceWithOptimalSolutions(X,Y,Z,x_random, y_random, optimal_solutions):
	figure_1 = plt.figure()
	axes_1 = figure_1.gca(projection='3d')
	surface_1 = axes_1.plot_surface(X, Y, Z, rstride=2, cstride=1, cmap=cm.jet,
	                       linewidth = 0, antialiased=False)
	[axes_1.plot(	[x_random[i], 						x_random[i], 	optimal_solutions[i][0]	],\
					[y_random[i], 						y_random[i], 	optimal_solutions[i][1]	],\
					[func([x_random[i],y_random[i]]), 	2, 				2						], \
					'b') for i in range(n)]
	[axes_1.plot(	[optimal_solutions[i][0], 	optimal_solutions[i][0]],\
					[optimal_solutions[i][1], 	optimal_solutions[i][1]],\
					[2.2,						func(optimal_solutions[i])],\
					'k') for i in range(n)]
	axes_1.set_xlim([-10,10])
	axes_1.set_ylim([-10,10])
	axes_1.set_zlim([-1.5,2])
	axes_1.view_init(30,-120)
	axes_1.set_xlabel('x')
	axes_1.set_ylabel('y')
	axes_1.set_zlabel('z')
	plt.show(block=True)

PlotSurfaceWithOptimalSolutions(X,Y,Z,x_random,y_random,optimal_solutions)




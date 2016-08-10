import numpy as np
import matplotlib
from matplotlib import cm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import random

matplotlib.rcParams['xtick.direction'] = 'out'
matplotlib.rcParams['ytick.direction'] = 'out'

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
X,Y = np.meshgrid(xx,yy)
def func(x):
	R = np.sqrt(x[0]**2 + x[1]**2) + 1.5*np.sin(2*x[0]) + 2*np.cos(3*x[1]) + np.spacing(1)
	Z = np.sin(R)/R
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
n = 10**5
threshold = 0.8

# SETTING SEED HERE, so that each time you run this you
# get a different set of random numbers
random.seed()

x_random = [random.uniform(x_lower_bound,x_upper_bound) for i in range(n)]
y_random = [random.uniform(y_lower_bound,y_upper_bound) for i in range(n)]

# Plot the resulting histograms for the random numbers
def PlotHistogram(X,bins):
	fig = plt.figure()
	ax = fig.gca()
	ax.spines['right'].set_visible(False)
	ax.spines['top'].set_visible(False)
	ax.xaxis.set_ticks_position('bottom')
	ax.yaxis.set_ticks_position('left')
	# the histogram of the data
	plt.hist(X,bins, normed=1, facecolor='green', alpha=0.75)
	plt.ylabel('Frequency')
	plt.show()

#PlotHistogram(x_random,5)
#PlotHistogram(y_random,5)

area = 0
running_area = []
index = []
coef_variation = []
x_area = []
y_area = []

# Monte Carlo Loop
for i in range(n):
	if func([x_random[i], y_random[i]]) > threshold:
		area +=1
		index.append(i)
		running_area.append(area*400/i)
		coef_variation.append(100*np.std(running_area)/np.mean(running_area))
		x_area.append(x_random[i])
		y_area.append(y_random[i])

def PlotMonteCarloAnalysis(area,running_area,coef_variation,index,area_value):
	fig = plt.figure(figsize = (15,13))
	text = 'Area =' + str(area_value*20*20/n)


	subplot_1 = plt.subplot(2,1,1)
	subplot_1.plot(area[0],area[1],'r.')
	subplot_1.contour(X,Y,Z,[threshold], colors = 'k', linewidth = 3)
	axes_1 = fig.gca()
	axes_1.spines['right'].set_visible(False)
	axes_1.spines['top'].set_visible(False)
	axes_1.xaxis.set_ticks_position('bottom')
	axes_1.yaxis.set_ticks_position('left')
	axes_1.set_xlabel('x')
	axes_1.set_ylabel('y')
	axes_1.set_title('Complex Region')
	axes_1.set_aspect('equal', 'datalim')
	axes_1.text(10, 5, text, style='italic', fontsize = 16,
        		bbox={'facecolor':'red', 'alpha':0.5, 'pad':10})

	subplot_2 = plt.subplot(2,2,3)
	subplot_2.plot(index,running_area,'r-')
	axes_2 = fig.gca()
	axes_2.spines['right'].set_visible(False)
	axes_2.spines['top'].set_visible(False)
	axes_2.xaxis.set_ticks_position('bottom')
	axes_2.yaxis.set_ticks_position('left')
	axes_2.set_xlabel('Trial')
	axes_2.set_ylabel('Running Area')
	axes_2.set_title('Progression of proportion of points in the target region')
	
	subplot_3 = plt.subplot(2,2,4)
	subplot_3.plot(index,coef_variation,'r-')
	axes_3 = fig.gca()
	axes_3.spines['right'].set_visible(False)
	axes_3.spines['top'].set_visible(False)
	axes_3.xaxis.set_ticks_position('bottom')
	axes_3.yaxis.set_ticks_position('left')
	axes_3.set_xlabel('Trial')
	axes_3.set_ylabel('Coefficient of Variation')
	axes_3.set_title('Progression of coefficient of variation')

	plt.show()

PlotMonteCarloAnalysis([x_area, y_area],running_area,coef_variation,index,area)

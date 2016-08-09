import numpy as np
from matplotlib import cm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

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
R = np.sqrt(X**2 + Y**2) + 1.5*np.sin(2*X) + 2*np.cos(3*Y) + np.spacing(1)
Z = np.sin(R)/R + 0.1*X + 0.005*Y 

# Show the terrain in Figure 1
figure_1 = plt.figure()
axes_1 = figure_1.gca(projection='3d')
surface_1 = axes_1.plot_surface(X, Y, Z, rstride=5, cstride=5, cmap=cm.coolwarm,
                       antialiased=False)
axes_1.set_xlim([-10,10])
axes_1.set_ylim([-10,10])
axes_1.set_zlim([-1.5,1.5])
plt.show(block=True)


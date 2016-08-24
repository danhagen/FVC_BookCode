# Simple Tendon Excursion Example
# for one joint with 4 muscles.
# (c) Daniel A Hagen
# August 2016
# University of Southern California

import numpy as np 
import matplotlib.pyplot as plt 

# Moment Arm Matrix
R = np.matrix([1,2,-2,-1])

# Define Joint Angle Trajectory and Reference Angle
Angle = (np.pi/2)*np.sin(np.arange(0, 4*np.pi,0.001))
ReferenceAngle = 0

# Define optimal tendon length for ReferenceAngle
OptimalLength1 = 10
OptimalLength2 = 10
OptimalLength3 = 10
OptimalLength4 = 10
OptimalLengths = np.matrix([OptimalLength1,OptimalLength2,OptimalLength3,OptimalLength4])

# Define ChangeInAngle to be the difference between 
# Angle and ReferenceAngle. Can only be done for 
# constant moment arm values, otherwise change in 
# angle must be calculated for each time step.	
ChangeInAngle = Angle - ReferenceAngle 

# Calculate change in tendon length (ChangeInExcursion)
ChangeInExcursion = -R.T*ChangeInAngle

# Calculate muscle length
MuscleLengths = ChangeInExcursion + OptimalLengths.T

plt.figure()
plt.plot(MuscleLengths.T)
plt.xlabel('Time Step Units')
plt.ylabel('Muscle Length')
plt.legend(['Muscle 1','Muscle 2','Muscle 3','Muscle 4'])
ax1 = plt.gca()
plt.show(ax1)
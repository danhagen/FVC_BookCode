# (c) Francisco Valero-Cuevas & Emily Lawrence
# June 2014, version 1.0
# Filename: FiveDOF_ArmModel_Neuromechanics_V5.m
# Example of fiber length changes and fiber velocities
# for a frisbee throw motion with a 5-DOF, 17-muscle arm model

import numpy as np 
from scipy.io import loadmat
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Load all data from FiveDOF_Model.mat by using scipy.io.loadmat()
# Conversion from dict to variables is done for easier reading.
# MUST MAKE SURE THAT FiveDOF_Model.mat IS DOWNLOADED TO THE 
# SAME FOLDER AS FiveDOF_model_frisbee_throw.py
output = loadmat('FiveDOF_Model.mat')
UpperArm, LowerArm, Hand = float(output['L1']),float(output['L2']),float(output['L3'])
ExtRotation, Adduction = output['angle_ext_rot_ds_rad'].T[0], output['angle_add_ds_rad'].T[0]
HorizAdduction, ElbowFlexion = output['angle_horiz_add_ds_rad'].T[0], output['angle_elbow_ds_rad'].T[0]
WristFlexion = output['angle_wrist_ds_rad'].T[0] 
R, OptimalLength = output['R'].T[0], output['lo'].T[0]
del(output)

# Define Movement Duration
# ChangeInTime is the amount of time between successive postures
# of the arm. There are 44 postures during the throwing motion,
# from start to realease.
# ChangeInTime = 3.8 therefore produces a throw movement duration
# of 167.2 ms from start to release, indicated by a red arm in
# the plot of arm postures. SpeedUpFactor, originally set to 1,
# lengthens the duration by that factor.

SpeedUpFactor = 1
ChangeInTime = 3.8/SpeedUpFactor

# Nominal Model - Joint Angles

# Initiation - 34 postures: from posture  1 to 34
# Throw-to-release - 29 postures: from posture 35 to 64
# Deceleration of throw - 15 postures: from posture 65 to 78

# The first 34 postures are initiation of the throw, as subject starts
# pointing frisbee at target (arm straight out to side) then draws the
# frisbee back to posture 35. The subject initiates the throw from posture
# 35 to release at posture 64. We will only consider post-Initiation phase
# postures (35-78).

Range = range(34,78)
Angles = [ExtRotation[Range], Adduction[Range], HorizAdduction[Range], ElbowFlexion[Range], WristFlexion[Range]] 

def plot_joint_angles(Angles,Range,Labels):
	"""
	Takes in a list of arrays for angles and the labels you wish to have in the legend. 
	"""
	size = len(Angles)
	plt.figure()
	ax = plt.gca()
	[plt.plot(Range,180*Angles[i]/np.pi) for i in range(size)]
	ax.legend(Labels)
	ax.set_xlabel('Postures')
	ax.set_ylabel('Joint Angles (degrees)')
	ax.set_title('Joint Angles During Throw Phase')
	ax.set_xlim([Range[0],Range[-1]])
	plt.show()

#plot_joint_angles(Angles,Range,['Ext Rot', 'Add', 'Horiz Add', 'EFE', 'WFE'])

# Create and plot geometric model for postures 35-78.

def upper_arm_x(UpperArm, Adduction, HorizAdduction):
	result = UpperArm*np.cos(Adduction)*np.cos(HorizAdduction)
	return(result)
def upper_arm_y(UpperArm, ExtRotation, Adduction, HorizAdduction):
	result = UpperArm*(np.cos(ExtRotation)*np.sin(HorizAdduction) + np.cos(HorizAdduction)*np.sin(ExtRotation)*np.sin(Adduction))
	return(result)
def upper_arm_z(UpperArm, ExtRotation, Adduction, HorizAdduction):
	result = UpperArm*(np.sin(ExtRotation)*np.sin(HorizAdduction) - np.cos(ExtRotation)*np.cos(HorizAdduction)*np.sin(Adduction))
	return(result)

def lower_arm_x(LowerArm, Adduction, HorizAdduction, ElbowFlexion):
	result = LowerArm*(np.cos(Adduction)*np.cos(HorizAdduction+ElbowFlexion))
	return(result)
def lower_arm_y(LowerArm, ExtRotation, Adduction, HorizAdduction, ElbowFlexion):
	result = LowerArm*(np.cos(ExtRotation)*np.sin(HorizAdduction+ElbowFlexion) + np.sin(ExtRotation)*np.sin(Adduction)*np.cos(HorizAdduction+ElbowFlexion))
	return(result)
def lower_arm_z(LowerArm, ExtRotation, Adduction, HorizAdduction, ElbowFlexion):
	result = LowerArm*(np.sin(ExtRotation)*np.sin(HorizAdduction+ElbowFlexion) - np.cos(ExtRotation)*np.sin(Adduction)*np.cos(HorizAdduction+ElbowFlexion))
	return(result)

def hand_x(Hand, Adduction, HorizAdduction, ElbowFlexion, WristFlexion):
	result = Hand*(np.sin(Adduction)*np.sin(WristFlexion) + \
					np.cos(WristFlexion)*np.cos(Adduction)*np.cos(HorizAdduction+ElbowFlexion))
	return(result)
def hand_y(Hand, ExtRotation, Adduction, HorizAdduction, ElbowFlexion, WristFlexion):
	result = Hand*(np.cos(WristFlexion)*(np.cos(ExtRotation)*np.sin(HorizAdduction+ElbowFlexion) + np.sin(ExtRotation)*np.sin(Adduction)*np.cos(HorizAdduction+ElbowFlexion)) - np.sin(ExtRotation)*np.cos(Adduction)*np.sin(WristFlexion))
	return(result)
def hand_z(Hand, ExtRotation, Adduction, HorizAdduction, ElbowFlexion, WristFlexion):
	result = Hand*(np.cos(WristFlexion)*(np.sin(ExtRotation)*np.sin(HorizAdduction+ElbowFlexion) - np.cos(ExtRotation)*np.sin(Adduction)*np.cos(HorizAdduction+ElbowFlexion)) + np.cos(ExtRotation)*np.cos(Adduction)*np.sin(WristFlexion))
	return(result)

def arm_position_x(UpperArm,LowerArm,Hand,Adduction,HorizAdduction,ElbowFlexion,WristFlexion):
	result = np.cumsum([upper_arm_x(UpperArm,Adduction,HorizAdduction),\
						lower_arm_x(LowerArm, Adduction, HorizAdduction, ElbowFlexion),\
						hand_x(Hand, Adduction, HorizAdduction, ElbowFlexion, WristFlexion)]) 
	return(np.array(result,ndmin = 2))
def arm_position_y(UpperArm,LowerArm,Hand,ExtRotation,Adduction,HorizAdduction,ElbowFlexion,WristFlexion):
	result = np.cumsum([upper_arm_y(UpperArm, ExtRotation, Adduction, HorizAdduction),\
						lower_arm_y(LowerArm, ExtRotation, Adduction, HorizAdduction, ElbowFlexion),\
						hand_y(Hand, ExtRotation, Adduction, HorizAdduction, ElbowFlexion, WristFlexion)]) 
	return(np.array(result,ndmin = 2))
def arm_position_z(UpperArm,LowerArm,Hand,ExtRotation,Adduction,HorizAdduction,ElbowFlexion,WristFlexion):
	result = np.cumsum([upper_arm_z(UpperArm, ExtRotation, Adduction, HorizAdduction),\
						lower_arm_z(LowerArm, ExtRotation, Adduction, HorizAdduction, ElbowFlexion),\
						hand_z(Hand, ExtRotation, Adduction, HorizAdduction, ElbowFlexion, WristFlexion)]) 
	return(np.array(result,ndmin = 2))

X = arm_position_x(UpperArm,LowerArm,Hand,Adduction[0],HorizAdduction[0],ElbowFlexion[0],WristFlexion[0])
Y = arm_position_y(UpperArm,LowerArm,Hand,ExtRotation[0],Adduction[0],HorizAdduction[0],ElbowFlexion[0],WristFlexion[0])
Z = arm_position_z(UpperArm,LowerArm,Hand,ExtRotation[0],Adduction[0],HorizAdduction[0],ElbowFlexion[0],WristFlexion[0])
for i in range(1,len(Range)):
	X = np.concatenate((X,arm_position_x(UpperArm,LowerArm,Hand,Adduction[i],HorizAdduction[i],ElbowFlexion[i],WristFlexion[i])),axis=0)
	Y = np.concatenate((Y,arm_position_y(UpperArm,LowerArm,Hand,ExtRotation[i],Adduction[i],HorizAdduction[i],ElbowFlexion[i],WristFlexion[i])),axis=0)
	Z = np.concatenate((Z,arm_position_z(UpperArm,LowerArm,Hand,ExtRotation[i],Adduction[i],HorizAdduction[i],ElbowFlexion[i],WristFlexion[i])),axis=0)

def plot_3D_trajectory(X,Y,Z,Range):
	figure_1 = plt.figure()
	ax = figure_1.gca(projection='3d')
	[ax.plot([0, X[i,0], X[i,1], X[i,2]],\
				[0, Y[i,0], Y[i,1], Y[i,2]],\
				[0, Z[i,0], Z[i,1], Z[i,2]], color = '0.75') for i in range(len(Range))]
	ax.plot([0],[0],[0],'k*')
	elbow = ax.plot(X[:,0], Y[:,0], Z[:,0], 'r*')
	wrsit = ax.plot(X[:,1], Y[:,1], Z[:,1], 'g*')
	end = ax.plot(X[:,2], Y[:,2], Z[:,2], 'k*')
	ax.set_xlabel('x')
	ax.set_ylabel('y')
	ax.set_zlabel('z')
	plt.show(block=True)

plot_3D_trajectory(X,Y,Z,Range)

% Muscle Excursion for 2 Limb System with 2 DOF
% Fmax2D2DOF.m
% Dan Hagen BME 504 October 2015
% University of Southern California

close all;clear all;
clc
% Define variables for symbolic analysis
syms R        % Moment Arm Matric functions
syms q1 q2 % Degrees of freedom
syms l1 l2     % System parameters
syms r1 r2 r3 r4 % constant moment arms

R = [[ -r1 -r1 r2 r2];[-r3 r4 -r3 r4]];

R_trans = R';

latex(R);
latex(R_trans);

% numerical examples

l1 = 0.8;
l2 = 0.5;

q1 = [0:0.01:(pi/2)];
q2 = [0:0.01:pi];
    
r1 = 10;
r2 = 7;
r3 = 8;
r4 = 12;

w = 0.5;
l1rest = 1;
l2rest = 1;
l3rest = 1;
l4rest = 1;

fprintf('Moment Arm Matrix R:');
subs(R)
fprintf('Transpose R'); 
subs(R_trans)

row = length(q1);
col = length(q2);

X=zeros(row,col);
for j=1:col
    for i=1:row
        X(i,j)=l1.*cos(q1(i))+l2.*cos(q1(i)+q2(j));
    end
end

Y=zeros(row,col);
for j=1:col
    for i=1:row
        Y(i,j)=l1.*sin(q1(i))+l2.*sin(q1(i)+q2(j));
    end
end

Fmax1=zeros(row,col);
for j=1:col
    for i=1:row
        if (((l1rest -(-10*q1(i) -8*q2(j)))/(l1rest -(-10*(pi/4) -8*(pi/2))))-1)>=0.5
            Fmax1(i,j) = 0;
        elseif (((l1rest -(-10*q1(i) -8*q2(j)))/(l1rest -(-10*(pi/4) -8*(pi/2))))-1)<=-0.5
            Fmax1(i,j) = 0;
        else
            Fmax1(i,j)= 1 - (((((l1rest -(-10*q1(i) -8*q2(j)))/(l1rest -(-10*(pi/4) -8*(pi/2))))-1)/w).^2);
        end
    end
end
Fmax2=zeros(row,col);
for j=1:col
    for i=1:row
        if (((l2rest -(-10*q1(i) + 12*q2(j)))/(l2rest -(-10*(pi/4) + 12*(pi/2))))-1)>=0.5
            Fmax2(i,j) = 0;
        elseif (((l2rest -(-10*q1(i) + 12*q2(j)))/(l2rest -(-10*(pi/4) + 12*(pi/2))))-1)<=-0.5
            Fmax2(i,j) = 0;
        else
            Fmax2(i,j)= 1 - (((((l2rest -(-10*q1(i) + 12*q2(j)))/(l2rest -(-10*(pi/4) + 12*(pi/2))))-1)/w).^2);
        end
    end
end
Fmax3=zeros(row,col);
for j=1:col
    for i=1:row
        if (((l3rest -(7*q1(i) -8*q2(j)))/(l3rest -(7*(pi/4) -8*(pi/2))))-1)>=0.5
            Fmax3(i,j) = 0;
        elseif (((l3rest -(7*q1(i) -8*q2(j)))/(l3rest -(7*(pi/4) -8*(pi/2))))-1)<=-0.5
            Fmax3(i,j) = 0;
        else
            Fmax3(i,j)= 1 - (((((l3rest -(7*q1(i) -8*q2(j)))/(l3rest -(7*(pi/4) -8*(pi/2))))-1)/w).^2);
        end
    end
end
Fmax4=zeros(row,col);
for j=1:col
    for i=1:row
        if (((l4rest -(7*q1(i) + 12*q2(j)))/(l4rest -(7*(pi/4) + 12*(pi/2))))-1)>=0.5
            Fmax4(i,j) = 0;
        elseif (((l4rest -(7*q1(i) + 12*q2(j)))/(l4rest -(7*(pi/4) + 12*(pi/2))))-1)<=-0.5
            Fmax4(i,j) = 0;
        else
            Fmax4(i,j)= 1 - (((((l4rest -(7*q1(i) + 12*q2(j)))/(l4rest -(7*(pi/4) + 12*(pi/2))))-1)/w).^2);
        end
    end
end
figure1 = figure('Position',[60 60 600 600],'Name','Range of Motion for 2D 2DOF Limb');

z1 = subplot(2,2,1)
mesh(X,Y,Fmax1)
xlim auto
ylim auto
zlim auto
title('Muscle 1')
xlabel('x (m)')
ylabel('y (m)')
zlabel('F_{max} (Normalized)')

z2 = subplot(2,2,2)
mesh(X,Y,Fmax2)
xlim auto
ylim auto
zlim auto
title('Muscle 2')
xlabel('x (m)')
ylabel('y (m)')
zlabel('F_{max} (Normalized)')

z3 = subplot(2,2,3)
mesh(X,Y,Fmax3)
xlim auto
ylim auto
zlim auto
title('Muscle 3')
xlabel('x (m)')
ylabel('y (m)')
zlabel('F_{max} (Normalized)')

z4 = subplot(2,2,4)
mesh(X,Y,Fmax4)
xlim auto
ylim auto
zlim auto
title('Muscle 4')
xlabel('x (m)')
ylabel('y (m)')
zlabel('F_{max} (Normalized)')


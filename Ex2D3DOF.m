% Muscle Excursion for 2 Limb System with 2 DOF
% Ex2D3DOF.m
% Dan Hagen BME 504 October 2015
% University of Southern California

close all;clear all;
clc
% Define variables for symbolic analysis
% syms R        % Moment Arm Matric functions
syms q1 q2 q3 % Degrees of freedom
syms l1 l2 l3     % System parameters
% syms r1 r2 r3 r4 % constant moment arms
% 
% R = [[ -r1 -r1 r2 r2];[-r3 r4 -r3 r4]];
% 
% R_trans = R';
% 
% latex(R);
% latex(R_trans);

% numerical examples

h = 1.76;
l1 = .185*h;
l2 = .146*h;
l3 = .108*h;

q1 = [(pi/2)-(pi/4):0.1:(pi/.99)-(pi/2)];
q2 = [0:0.1:(pi/2.1)];
q3 = [-(pi/1.1):0.1:(pi/1.1)];

    
% r1 = 10;
% r2 = 7;
% r3 = 8;
% r4 = 12;
% 
% fprintf('Moment Arm Matrix R:');
% subs(R)
% fprintf('Transpose R'); 
% subs(R_trans)

row = length(q1);
col = length(q2);
depth = length(q3);

Y=zeros(row,col);
for j=1:col
    for i=1:row
        for k=1:depth
            Y(i,j,k)=l1.*cos(q1(i))+l2.*cos(q1(i)+q2(j))l3.*cos(q1(i)+q2(j)+q3(k));
        end
    end
end

X=zeros(row,col);
for j=1:col
    for i=1:row
        for k=1:depth
            X(i,j,k)=l1.*sin(q1(i))+l2.*sin(q1(i)+q2(j))+l3.*sin(q1(i)+q2(j)+q3(k));
        end
    end
end

x=[];
for i=1:depth
    for k=1:col
        x = [x; X(:,k,i)];
    end
end

y=[];
for i=1:depth
    for k=1:col
        y = [y; Y(:,k,i)];
    end
end

plot(x,y)
hold on
F = line([0 0 0 0],[0 l1 l1+l2 l1+l2+l3],'Color','k','LineWidth',3,'Marker','o','MarkerEdgeColor','r','MarkerFaceColor',[.8 .8 .8]);

% Z1=zeros(row,col);
% for j=1:col
%     for i=1:row
%         Z1(i,j)=-(-10*q1(i) -8*q2(j));
%     end
% end
% Z2=zeros(row,col);
% for j=1:col
%     for i=1:row
%         Z2(i,j)=-(-10*q1(i) +12*q2(j));
%     end
% end
% Z3=zeros(row,col);
% for j=1:col
%     for i=1:row
%         Z3(i,j)=-(7*q1(i) -8*q2(j));
%     end
% end
% Z4=zeros(row,col);
% for j=1:col
%     for i=1:row
%         Z4(i,j)=-(7*q1(i) +12*q2(j));
%     end
% end
% figure1 = figure('Position',[60 60 600 600],'Name','Range of Motion for 2D 2DOF Limb');
% 
% z1 = subplot(2,2,1)
% mesh(X,Y,Z1)
% xlim auto
% ylim auto
% zlim auto
% title('Muscle 1')
% xlabel('x (cm)')
% ylabel('y (cm)')
% zlabel('Excursion')
% 
% z2 = subplot(2,2,2)
% mesh(X,Y,Z2)
% xlim auto
% ylim auto
% zlim auto
% title('Muscle 2')
% xlabel('x (cm)')
% ylabel('y (cm)')
% zlabel('Excursion')
% 
% z3 = subplot(2,2,3)
% mesh(X,Y,Z3)
% xlim auto
% ylim auto
% zlim auto
% title('Muscle 3')
% xlabel('x (cm)')
% ylabel('y (cm)')
% zlabel('Excursion')
% 
% z4 = subplot(2,2,4)
% mesh(X,Y,Z4)
% xlim auto
% ylim auto
% zlim auto
% title('Muscle 4')
% xlabel('x (cm)')
% ylabel('y (cm)')
% zlabel('Excursion')


% Maximal Static Force for Taping the Ceiling - 10 Postures
% FmaxActivation.m
% Dan Hagen BME 504 November 2015
% University of Southern California


% To run, please make sure this file is in the same folder 
% as Dr. Valero-Cuecvas' Ncube.m file and then press Run.
% Program is nested to graph for all 10 postures when ran.

close all;clear all;
clc

l1 = 80;
l2 = 50;

q1 = [1.1908 1.0621 0.813389 0.700844 0.601398 0.518223 0.453598 0.409172 0.386661 0.389248];
q2 = [1.83641 1.87549 1.87549 1.83641 1.77215 1.68353 1.5708 1.43286 1.2661 1.06157];
    
r1 = 10;
r2 = 7;
r3 = 8;
r4 = 12;

w = 0.5;
l_o_1 = 20;
l_o_2 = 10;
l_o_3 = 20;
l_o_4 = 15;

l1rest = 20 - 6.5*pi;
l2rest = 10 + 3.5*pi;
l3rest = 20 - 2.25*pi;
l4rest = 15 + 7.75*pi;

for i=1:10

    l_1_hat = (l1rest + 10*q1(i) + 8*q2(i))/20 - 1;
    l_2_hat = (l2rest + 10*q1(i) - 12*q2(i))/10 - 1;
    l_3_hat = (l3rest - 7*q1(i) + 8*q2(i))/20 - 1;
    l_4_hat = (l4rest - 7*q1(i) - 12*q2(i))/15 - 1;

    F_max_1 = 1 - ((l_1_hat./w).^2);
    F_max_2 = 1 - ((l_2_hat./w).^2);
    F_max_3 = 1 - ((l_3_hat./w).^2);
    F_max_4 = 1 - ((l_4_hat./w).^2);

    F_o = [[F_max_1*10*35 0 0 0];[0 F_max_2*20*35 0 0];[0 0 F_max_3*15*35 0];[0 0 0 F_max_4*25*35]];
    R = [[-10 -10 7 7];[-8 12 -8 12]];
    J = [[(-80*sin(q1(i))-50*sin(q1(i)+q2(i))) -50*sin(q1(i)+q2(i))];[(80*cos(q1(i)) + 50*cos(q1(i)+q2(i))) 50*cos(q1(i)+q2(i))]];
    J_inv = inv(J);
    J_inv_trans = J_inv';
    
    a_vert = ncube(4);
    H = J_inv_trans*R*F_o;
    
    F_vert = [];
    F_vert = [F_vert H*(a_vert')];
    outer_F_vert = convhull(F_vert(1,:),F_vert(2,:));
    fig1 = figure('Name',['Posture #' num2str(i) ': q = [' num2str(q1(i)) ', ' num2str(q2(i)) ']']);
        plot(F_vert(1,outer_F_vert(:)),F_vert(2,outer_F_vert(:)),'r'); hold on;
        line([0 0], [-300 300],'Color','k');  %x-axis
        line([-300 300], [0 0],'Color','k');  %y-axis
        xlabel('Force in x (N)');
        ylabel('Force in y (N)');
        axis equal;   
end



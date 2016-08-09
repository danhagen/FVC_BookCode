% Muscle Excursion for 2 Limb System with 2 DOF
% FmaxActivation.m
% Dan Hagen BME 504 October 2015
% University of Southern California

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

for i=1:1

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
    
    H = J_inv_trans*R*F_o;  
    h_1_trans = H(1,:);
    h_2_trans = H(2,:);
    
    A = [h_1_trans; -h_1_trans;[1 0 0 0];[0 1 0 0];[0 0 1 0];[0 0 0 1];[-1 0 0 0];[0 -1 0 0];[0 0 -1 0];[0 0 0 -1]];
    b = [0.001 0.001 1 1 1 1 0 0 0 0]';
    
    act = linprog(-h_2_trans,A,b);
    
    Force = H*act;
    
    name = strcat('Limb Configuration, Muscle Activation and Force Magnitude for q = [', num2str(q1(i)),', ',num2str(q2(i)),']''');
    figure('Name',name,'Position',[200,200,480,180+l1*sin(q1(i))+l2*sin(q1(i)+q2(i))+Force(2)]);
    
    subplot(1,2,1);
    a1 = rectangle('Position',[-100,100,200,Force(2)+15],'EdgeColor','k','FaceColor','b');
    ceiling = text(-90,105,'Ceiling');

    forcevect = line([l1*cos(q1(i))+l2*cos(q1(i)+q2(i)) l1*cos(q1(i))+l2*cos(q1(i)+q2(i))],[20+l1*sin(q1(i))+l2*sin(q1(i)+q2(i)) 20+l1*sin(q1(i))+l2*sin(q1(i)+q2(i))+Force(2)],'Marker','^','Color','r','LineWidth',2);
    box = rectangle('Position',[-30,0,60,17],'FaceColor','k');
    arm = line([0  l1*cos(q1(i)) l1*cos(q1(i))+l2*cos(q1(i)+q2(i))],[20 20+l1*sin(q1(i)) 20+l1*sin(q1(i))+l2*sin(q1(i)+q2(i))],'LineWidth',2.5,'Color',[.8 .8 .8],'Marker','o','MarkerFaceColor','k','MarkerEdgeColor','k');
   
    
    forcemag = strcat('f_{y}',' = ',num2str(Force(2)),' N');
    text(-45,40+l1*sin(q1(i))+l2*sin(q1(i)+q2(i))+Force(2),forcemag);
    
    xlim([-100 100]);
    ylim([0 35.0001+l1*sin(q1(i))+l2*sin(q1(i)+q2(i))+Force(2)]);
    xlabel('x (m)');
    ylabel('y (m)');
    
    subplot(1,2,2);
    
    for i=1:4
        if act(i)<0.001
            act(i)=0;
        end
    end
    
    bar([1 2 3 4],act','r');
    xlim([0.5 4.5]);
    ylim([0 1.1]);
    xlabel('Muscle No.');
    ylabel('Percent Activated');
            
    
end



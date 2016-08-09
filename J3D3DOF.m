%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% NEUROMECHANICS  %%%%%%%%%%%%%
% September 2013, version 1.0
% Filename: J3D3DOF.m
% Jacobian of 3D, 3DOF linkage system

% Clear memory and screen
close all;clear all;
clc
% Define variables for symbolic analysis
syms G J        % Vector functions
syms q1 q2 q3 x y alpha  % Degrees of freedom
syms l1 l2 l3     % System parameters
%Define x and y coordinates of the endpoint
%Create Matrix for Geometric Model
x = l1.*cos(q1) + l2.*cos(q1+q2) + l3.*cos(q1+q2+q3);
y = l1.*sin(q1) + l2.*sin(q1+q2) + l3.*sin(q1+q2+q3);
alpha = q1 + q2 + q3
G = [x;y;alpha]
%Create Jacobian and its permutations
J = jacobian(G,[q1,q2,q3])
J_inv = inv(J)
J_trans = J'
J_trans_inv = inv(J')

latex(G)
latex(J)
latex(J_trans)
latex(J_inv)
latex(J_trans_inv)
% Numerical example
% Define Link Lengths (m)
l1 = 1
l2 = 1
l3 = 1

% Define join angles (radians)
q1 = 0     % 0 degrees
q2 = pi/4  % 45 degrees
q3 = pi/4  % 45 degrees
fprintf('Evaluate the functions for these parameter values\n')
fprintf('G');subs(G)
fprintf('J');subs(J)
fprintf('J_trans');subs(J_trans)
fprintf('J_inv');subs(J_inv)
fprintf('J_trans_inv');subs(J_trans_inv)

figure('Position',[60 60 1200 600],'Name','q = (0, pi/4, pi/4)''');
position_a1 = subplot(1,2,1,'Position',[0.025 0.0483333333333333 0.4475 0.94]);
xlim([-3.5 3]);
ylim([-1.5 5]);

g = line([-.25 -.25],[1 -1]);
set(g,'Color','black','LineWidth', 1.5);
g1 = line([-.5 -.25],[-1 -.75]);
set(g1,'Color','black');
g2 = line([-.5 -.25],[-.75 -.5]);
set(g2,'Color','black');
g3 = line([-.5 -.25],[-.5 -.25]);
set(g3,'Color','black');
g4 = line([-.5 -.25],[-.25 0]);
set(g4,'Color','black');
g5 = line([-.5 -.25],[0 .25]);
set(g5,'Color','black');
g6 = line([-.5 -.25],[.25 .5]);
set(g6,'Color','black');
g7 = line([-.5 -.25],[.5 .75]);
set(g7,'Color','black');
g8 = line([-.5 -.25],[.75 1]);
set(g8,'Color','black');

b = line([-.25 .25 .25 -.25 -.25],[.25 .25 -.25 -.25 .25]);
set(b,'Color','black');
set(b,'LineWidth',2);

l = line([0 cos(q1) cos(q1)+cos(q1+q2) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[0 sin(q1) sin(q1)+sin(q1+q2) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)]);
set(l,'LineWidth',6);
set(l,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');
set(l,'Color','black');

q1_dot_i = 1;
q2_dot_i = 0;
q3_dot_i = 0;

x_dot_i = subs(J*[q1_dot_i q2_dot_i q3_dot_i]');

i = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_i(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_i(2)]);
set(i,'Color','red','Marker','v','LineWidth',2);
fprintf('x_dot_i');subs(x_dot_i)

q1_dot_ii = 0;
q2_dot_ii = 1;
q3_dot_ii = 0;

x_dot_ii = subs(J*[q1_dot_ii q2_dot_ii q3_dot_ii]');

ii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_ii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_ii(2)]);
set(ii,'Color','blue','Marker','v','LineWidth',2);
fprintf('x_dot_ii');subs(x_dot_ii)

q1_dot_iii = 0;
q2_dot_iii = 0;
q3_dot_iii = 1;

x_dot_iii = subs(J*[q1_dot_iii q2_dot_iii q3_dot_iii]');

iii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_iii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_iii(2)]);
set(iii,'Color','green','Marker','<','LineWidth',2);
fprintf('x_dot_iii');subs(x_dot_iii)

q1_dot_iv = 1;
q2_dot_iv = 1;
q3_dot_iv = 1;

x_dot_iv = subs(J*[q1_dot_iv q2_dot_iv q3_dot_iv]');

iv = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_iv(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_iv(2)]);
set(iv,'Color','m','Marker','v','LineWidth',2);
fprintf('x_dot_iv');subs(x_dot_iv)

dot = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3)]);
set(dot,'LineWidth',6);
set(dot,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');

legend([i,ii,iii,iv],'q_{dot} = (1,0,0)''','q_{dot} = (0,1,0)''','q_{dot} = (0,0,1)''','q_{dot} = (1,1,1)''');

position_a2 = subplot(1,2,2,'Position',[0.537500000000002 0.0483333333333334 0.439166666666666 0.94]);
xlim([-1.5 5]);
ylim([-1.5 5]);
zlim([-3 3]);

g = line([-.25 -.25],[1 -1],[0 0]);
set(g,'Color','black','LineWidth', 1.5);
g1 = line([-.5 -.25],[-1 -.75],[0 0]);
set(g1,'Color','black');
g2 = line([-.5 -.25],[-.75 -.5],[0 0]);
set(g2,'Color','black');
g3 = line([-.5 -.25],[-.5 -.25],[0 0]);
set(g3,'Color','black');
g4 = line([-.5 -.25],[-.25 0],[0 0]);
set(g4,'Color','black');
g5 = line([-.5 -.25],[0 .25],[0 0]);
set(g5,'Color','black');
g6 = line([-.5 -.25],[.25 .5],[0 0]);
set(g6,'Color','black');
g7 = line([-.5 -.25],[.5 .75],[0 0]);
set(g7,'Color','black');
g8 = line([-.5 -.25],[.75 1],[0 0]);
set(g8,'Color','black');

b = line([-.25 .25 .25 -.25 -.25],[.25 .25 -.25 -.25 .25],[0 0 0 0 0]);
set(b,'Color','black');
set(b,'LineWidth',2);

l = line([0 cos(q1) cos(q1)+cos(q1+q2) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[0 sin(q1) sin(q1)+sin(q1+q2) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 0 0 0]);
set(l,'LineWidth',6);
set(l,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');
set(l,'Color','black');

tau_v = [1 0 0]';

f_v = subs(J_trans_inv*tau_v);

v = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_v(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_v(2)],[0 0]);
set(v,'Color','red','Marker','v','LineWidth',2,'LineStyle','--');
v_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_v(3)]);
set(v_tau,'Color','red','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_v');subs(f_v)

tau_vi = [0 1 0]';

f_vi = subs(J_trans_inv)*tau_vi;

vi = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_vi(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_vi(2)],[0 0]);
set(vi,'Color','blue','Marker','^','LineWidth',2,'LineStyle','--');
vi_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_vi(3)]);
set(vi_tau,'Color','blue','Marker','v','LineWidth',2,'LineStyle','--');
fprintf('f_vi');subs(f_vi)

tau_vii = [0 0 1]';

f_vii = subs(J_trans_inv)*tau_vii;

vii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_vii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_vii(2)],[0 0]);
set(vii,'Color','green','Marker','>','LineWidth',2,'LineStyle','--');
vii_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_vii(3)]);
set(vii_tau,'Color','green','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_vii');subs(f_vii)

tau_viii = [1 1 1]';

f_viii = subs(J_trans_inv*tau_viii);

viii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_viii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_viii(2)],[0 0]);
set(viii,'Color','m','Marker','v','LineWidth',2,'LineStyle','--');
viii_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_viii(3)]);
set(viii_tau,'Color','m','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_viii');subs(f_viii)

dot = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0]);
set(dot,'LineWidth',6);
set(dot,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');

v_tau_string = ['tau_{alpha} = ', num2str(double(f_v(3)))];
vi_tau_string = ['tau_{alpha} = ', num2str(double(f_vi(3)))];
vii_tau_string = ['tau_{alpha} = ', num2str(double(f_vii(3)))];
viii_tau_string = ['tau_{alpha} = ', num2str(double(f_viii(3)))];
legend2 = legend([v, v_tau, vi, vi_tau, vii, vii_tau, viii, viii_tau],'tau = (1,0,0)''',v_tau_string,'tau = (0,1,0)''',vi_tau_string,'tau = (0,0,1)''', vii_tau_string,'tau = (1,1,1)''', viii_tau_string);

% Define join angles (radians)
q1 = 0     % 0 degrees
q2 = pi/2  % 90 degrees
q3 = pi/4  % 45 degrees
fprintf('Evaluate the functions for these parameter values\n')
fprintf('G');subs(G)
fprintf('J');subs(J)
fprintf('J_trans');subs(J_trans)
fprintf('J_inv');subs(J_inv)
fprintf('J_trans_inv');subs(J_trans_inv)

figure('Position',[60 60 1200 600],'Name','q = (0, pi/2, pi/4)''');
position_b1 = subplot(1,2,1,'Position',[0.025 0.0483333333333333 0.4475 0.94]);
xlim([-5 1.5]);
ylim([-2 4]);

g = line([-.25 -.25],[1 -1]);
set(g,'Color','black','LineWidth', 1.5);
g1 = line([-.5 -.25],[-1 -.75]);
set(g1,'Color','black');
g2 = line([-.5 -.25],[-.75 -.5]);
set(g2,'Color','black');
g3 = line([-.5 -.25],[-.5 -.25]);
set(g3,'Color','black');
g4 = line([-.5 -.25],[-.25 0]);
set(g4,'Color','black');
g5 = line([-.5 -.25],[0 .25]);
set(g5,'Color','black');
g6 = line([-.5 -.25],[.25 .5]);
set(g6,'Color','black');
g7 = line([-.5 -.25],[.5 .75]);
set(g7,'Color','black');
g8 = line([-.5 -.25],[.75 1]);
set(g8,'Color','black');

b = line([-.25 .25 .25 -.25 -.25],[.25 .25 -.25 -.25 .25]);
set(b,'Color','black');
set(b,'LineWidth',2);

l = line([0 cos(q1) cos(q1)+cos(q1+q2) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[0 sin(q1) sin(q1)+sin(q1+q2) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)]);
set(l,'LineWidth',6);
set(l,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');
set(l,'Color','black');

q1_dot_i = 1;
q2_dot_i = 0;
q3_dot_i = 0;

x_dot_i = subs(J*[q1_dot_i q2_dot_i q3_dot_i]');

i = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_i(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_i(2)]);
set(i,'Color','red','Marker','v','LineWidth',2);
fprintf('x_dot_i');subs(x_dot_i)

q1_dot_ii = 0;
q2_dot_ii = 1;
q3_dot_ii = 0;

x_dot_ii = subs(J*[q1_dot_ii q2_dot_ii q3_dot_ii]');

ii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_ii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_ii(2)]);
set(ii,'Color','blue','Marker','v','LineWidth',2);
fprintf('x_dot_ii');subs(x_dot_ii)

q1_dot_iii = 0;
q2_dot_iii = 0;
q3_dot_iii = 1;

x_dot_iii = subs(J*[q1_dot_iii q2_dot_iii q3_dot_iii]');

iii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_iii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_iii(2)]);
set(iii,'Color','green','Marker','<','LineWidth',2);
fprintf('x_dot_iii');subs(x_dot_iii)

q1_dot_iv = 1;
q2_dot_iv = 1;
q3_dot_iv = 1;

x_dot_iv = subs(J*[q1_dot_iv q2_dot_iv q3_dot_iv]');

iv = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_iv(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_iv(2)]);
set(iv,'Color','m','Marker','v','LineWidth',2);
fprintf('x_dot_iv');subs(x_dot_iv)

dot = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3)]);
set(dot,'LineWidth',6);
set(dot,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');

legend([i,ii,iii,iv],'q_{dot} = (1,0,0)''','q_{dot} = (0,1,0)''','q_{dot} = (0,0,1)''','q_{dot} = (1,1,1)''','Position','southeast');

position_b2 = subplot(1,2,2,'Position',[0.537500000000002 0.0483333333333334 0.439166666666666 0.94]);
xlim([-2 2]);
ylim([-1 3]);
zlim([-2 2]);

g = line([-.25 -.25],[1 -1],[0 0]);
set(g,'Color','black','LineWidth', 1.5);
g1 = line([-.5 -.25],[-1 -.75],[0 0]);
set(g1,'Color','black');
g2 = line([-.5 -.25],[-.75 -.5],[0 0]);
set(g2,'Color','black');
g3 = line([-.5 -.25],[-.5 -.25],[0 0]);
set(g3,'Color','black');
g4 = line([-.5 -.25],[-.25 0],[0 0]);
set(g4,'Color','black');
g5 = line([-.5 -.25],[0 .25],[0 0]);
set(g5,'Color','black');
g6 = line([-.5 -.25],[.25 .5],[0 0]);
set(g6,'Color','black');
g7 = line([-.5 -.25],[.5 .75],[0 0]);
set(g7,'Color','black');
g8 = line([-.5 -.25],[.75 1],[0 0]);
set(g8,'Color','black');

b = line([-.25 .25 .25 -.25 -.25],[.25 .25 -.25 -.25 .25],[0 0 0 0 0]);
set(b,'Color','black');
set(b,'LineWidth',2);

l = line([0 cos(q1) cos(q1)+cos(q1+q2) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[0 sin(q1) sin(q1)+sin(q1+q2) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 0 0 0]);
set(l,'LineWidth',6);
set(l,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');
set(l,'Color','black');

tau_v = [1 0 0]';

f_v = subs(J_trans_inv*tau_v);

v = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_v(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_v(2)],[0 0]);
set(v,'Color','red','Marker','v','LineWidth',2,'LineStyle','--');
v_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_v(3)]);
set(v_tau,'Color','red','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_v');subs(f_v)

tau_vi = [0 1 0]';

f_vi = subs(J_trans_inv)*tau_vi;

vi = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_vi(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_vi(2)],[0 0]);
set(vi,'Color','blue','Marker','^','LineWidth',2,'LineStyle','--');
vi_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_vi(3)]);
set(vi_tau,'Color','blue','Marker','v','LineWidth',2,'LineStyle','--');
fprintf('f_vi');subs(f_vi)

tau_vii = [0 0 1]';

f_vii = subs(J_trans_inv)*tau_vii;

vii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_vii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_vii(2)],[0 0]);
set(vii,'Color','green','Marker','>','LineWidth',2,'LineStyle','--');
vii_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_vii(3)]);
set(vii_tau,'Color','green','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_vii');subs(f_vii)

tau_viii = [1 1 1]';

f_viii = subs(J_trans_inv*tau_viii);

viii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_viii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_viii(2)],[0 0]);
set(viii,'Color','m','Marker','v','LineWidth',2,'LineStyle','--');
viii_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_viii(3)]);
set(viii_tau,'Color','m','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_viii');subs(f_viii)

dot = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0]);
set(dot,'LineWidth',6);
set(dot,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');

v_tau_string = ['tau_{alpha} = ', num2str(double(f_v(3)))];
vi_tau_string = ['tau_{alpha} = ', num2str(double(f_vi(3)))];
vii_tau_string = ['tau_{alpha} = ', num2str(double(f_vii(3)))];
viii_tau_string = ['tau_{alpha} = ', num2str(double(f_viii(3)))];
legend2 = legend([v, v_tau, vi, vi_tau, vii, vii_tau, viii, viii_tau],'tau = (1,0,0)''',v_tau_string,'tau = (0,1,0)''',vi_tau_string,'tau = (0,0,1)''', vii_tau_string,'tau = (1,1,1)''', viii_tau_string);
set(legend2,'Position',[0.559861111111111 0.673055555555556 0.136666666666667 0.296666666666667]);

% Define join angles (radians)
q1 = 0     % 0 degrees
q2 = pi/2  % 90 degrees
q3 = pi/2  % 90 degrees
fprintf('Evaluate the functions for these parameter values\n')
fprintf('G');subs(G)
fprintf('J');subs(J)
fprintf('J_trans');subs(J_trans)
fprintf('J_inv');subs(J_inv)
fprintf('J_trans_inv');subs(J_trans_inv)

figure('Position',[60 60 1200 600],'Name','q = (0, pi/2, pi/2)''');
position_c1 = subplot(1,2,1,'Position',[0.025 0.0483333333333333 0.4475 0.94]);
xlim([-3.5 3]);
ylim([-3 3.5]);

g = line([-.25 -.25],[1 -1]);
set(g,'Color','black','LineWidth', 1.5);
g1 = line([-.5 -.25],[-1 -.75]);
set(g1,'Color','black');
g2 = line([-.5 -.25],[-.75 -.5]);
set(g2,'Color','black');
g3 = line([-.5 -.25],[-.5 -.25]);
set(g3,'Color','black');
g4 = line([-.5 -.25],[-.25 0]);
set(g4,'Color','black');
g5 = line([-.5 -.25],[0 .25]);
set(g5,'Color','black');
g6 = line([-.5 -.25],[.25 .5]);
set(g6,'Color','black');
g7 = line([-.5 -.25],[.5 .75]);
set(g7,'Color','black');
g8 = line([-.5 -.25],[.75 1]);
set(g8,'Color','black');

b = line([-.25 .25 .25 -.25 -.25],[.25 .25 -.25 -.25 .25]);
set(b,'Color','black');
set(b,'LineWidth',2);

l = line([0 cos(q1) cos(q1)+cos(q1+q2) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[0 sin(q1) sin(q1)+sin(q1+q2) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)]);
set(l,'LineWidth',6);
set(l,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');
set(l,'Color','black');

q1_dot_i = 1;
q2_dot_i = 0;
q3_dot_i = 0;

x_dot_i = subs(J*[q1_dot_i q2_dot_i q3_dot_i]');

i = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_i(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_i(2)]);
set(i,'Color','red','Marker','v','LineWidth',2);
fprintf('x_dot_i');subs(x_dot_i)

q1_dot_ii = 0;
q2_dot_ii = 1;
q3_dot_ii = 0;

x_dot_ii = subs(J*[q1_dot_ii q2_dot_ii q3_dot_ii]');

ii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_ii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_ii(2)]);
set(ii,'Color','blue','Marker','v','LineWidth',2);
fprintf('x_dot_ii');subs(x_dot_ii)

q1_dot_iii = 0;
q2_dot_iii = 0;
q3_dot_iii = 1;

x_dot_iii = subs(J*[q1_dot_iii q2_dot_iii q3_dot_iii]');

iii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_iii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_iii(2)]);
set(iii,'Color','green','Marker','<','LineWidth',2);
fprintf('x_dot_iii');subs(x_dot_iii)

q1_dot_iv = 1;
q2_dot_iv = 1;
q3_dot_iv = 1;

x_dot_iv = subs(J*[q1_dot_iv q2_dot_iv q3_dot_iv]');

iv = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+x_dot_iv(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+x_dot_iv(2)]);
set(iv,'Color','m','Marker','v','LineWidth',2);
fprintf('x_dot_iv');subs(x_dot_iv)

dot = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3)]);
set(dot,'LineWidth',6);
set(dot,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');

legend([i,ii,iii,iv],'q_{dot} = (1,0,0)''','q_{dot} = (0,1,0)''','q_{dot} = (0,0,1)''','q_{dot} = (1,1,1)''','Position','southeast');

position_c2 = subplot(1,2,2,'Position',[0.537500000000002 0.0483333333333334 0.439166666666666 0.94]);
xlim([-2 2]);
ylim([-1 3]);
zlim([-2 2]);

g = line([-.25 -.25],[1 -1],[0 0]);
set(g,'Color','black','LineWidth', 1.5);
g1 = line([-.5 -.25],[-1 -.75],[0 0]);
set(g1,'Color','black');
g2 = line([-.5 -.25],[-.75 -.5],[0 0]);
set(g2,'Color','black');
g3 = line([-.5 -.25],[-.5 -.25],[0 0]);
set(g3,'Color','black');
g4 = line([-.5 -.25],[-.25 0],[0 0]);
set(g4,'Color','black');
g5 = line([-.5 -.25],[0 .25],[0 0]);
set(g5,'Color','black');
g6 = line([-.5 -.25],[.25 .5],[0 0]);
set(g6,'Color','black');
g7 = line([-.5 -.25],[.5 .75],[0 0]);
set(g7,'Color','black');
g8 = line([-.5 -.25],[.75 1],[0 0]);
set(g8,'Color','black');

b = line([-.25 .25 .25 -.25 -.25],[.25 .25 -.25 -.25 .25],[0 0 0 0 0]);
set(b,'Color','black');
set(b,'LineWidth',2);

l = line([0 cos(q1) cos(q1)+cos(q1+q2) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[0 sin(q1) sin(q1)+sin(q1+q2) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 0 0 0]);
set(l,'LineWidth',6);
set(l,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');
set(l,'Color','black');

tau_v = [1 0 0]';

f_v = subs(J_trans_inv*tau_v);

v = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_v(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_v(2)],[0 0]);
set(v,'Color','red','Marker','v','LineWidth',2,'LineStyle','--');
v_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_v(3)]);
set(v_tau,'Color','red','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_v');subs(f_v)

tau_vi = [0 1 0]';

f_vi = subs(J_trans_inv)*tau_vi;

vi = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_vi(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_vi(2)],[0 0]);
set(vi,'Color','blue','Marker','^','LineWidth',2,'LineStyle','--');
vi_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_vi(3)]);
set(vi_tau,'Color','blue','Marker','v','LineWidth',2,'LineStyle','--');
fprintf('f_vi');subs(f_vi)

tau_vii = [0 0 1]';

f_vii = subs(J_trans_inv)*tau_vii;

vii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_vii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_vii(2)],[0 0]);
set(vii,'Color','green','Marker','>','LineWidth',2,'LineStyle','--');
vii_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_vii(3)]);
set(vii_tau,'Color','green','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_vii');subs(f_vii)

tau_viii = [1 1 1]';

f_viii = subs(J_trans_inv*tau_viii);

viii = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)+f_viii(1)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)+f_viii(2)],[0 0]);
set(viii,'Color','m','Marker','v','LineWidth',2,'LineStyle','--');
viii_tau = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3) cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3) sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0 f_viii(3)]);
set(viii_tau,'Color','m','Marker','^','LineWidth',2,'LineStyle','--');
fprintf('f_viii');subs(f_viii)

dot = line([cos(q1)+cos(q1+q2)+cos(q1+q2+q3)],[sin(q1)+sin(q1+q2)+sin(q1+q2+q3)],[0]);
set(dot,'LineWidth',6);
set(dot,'Marker','o','MarkerEdgeColor',[.8 .8 .8],'MarkerFaceColor','black');

v_tau_string = ['tau_{alpha} = ', num2str(double(f_v(3)))];
vi_tau_string = ['tau_{alpha} = ', num2str(double(f_vi(3)))];
vii_tau_string = ['tau_{alpha} = ', num2str(double(f_vii(3)))];
viii_tau_string = ['tau_{alpha} = ', num2str(double(f_viii(3)))];
legend2 = legend([v, v_tau, vi, vi_tau, vii, vii_tau, viii, viii_tau],'tau = (1,0,0)''',v_tau_string,'tau = (0,1,0)''',vi_tau_string,'tau = (0,0,1)''', vii_tau_string,'tau = (1,1,1)''', viii_tau_string);


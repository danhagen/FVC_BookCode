%Example of code that uses Monte Carlo methods to find n different
% starting points to use gradient-based optimization to find the maximum
% height in a very rough terrain.
% BME 599  Francisco Valero-Cuevas, Copyright 2010
clear all;
close all;
%****************  Define the equal ranges for variables X and Y 

UB = 10;
LB = -10;
x_lb = LB;
x_ub = UB;
y_lb = LB;
y_ub = UB;

%**************** Create the terrain for the function to be optimized that
% represents a very rough terrain
[X,Y] = meshgrid(LB:.1:UB);
R = sqrt(X.^2 + Y.^2) + 1.5*sin(2*X) + 2* cos(3*Y) + eps;
Z = sin(R)./R + X*.1 + Y * .005;

% Show the terrain in Figure 1
fig1= surf(X,Y,Z,'FaceColor','interp',...
    'EdgeColor','none',...
    'FaceLighting','phong');
daspect([5 5 1])
axis tight
view(-50,30)
camlight left
%**************** Sample n random values of X and Y
n = 1e1;

% SETTING SEED HERE, so that each time you run this you get a different set
% of random numbers
tstart = clock;
seed = round(sum(1000*tstart));
rand('state',seed);             % NOTE: This sets the seed for the UNIFORM distribution only.
% save tempseed seed -ASCII;    % Saving seed if you want to repeat the exact same simulation later.

xr = random('unif', x_lb, x_ub, n, 1);
yr = random('unif', y_lb, y_ub, n, 1);

% Plot the histogram of the n random values of X and Y
fig2 = figure;
subplot(211); hist(xr);
subplot(212); hist(yr);

%**************************** Run the optimization with lsqnonlin
% CANNOT USE EQUALITY CONSTRAINTS IN X
OPTIONS=optimset('LargeScale','off', 'MaxFunEvals',600, 'MaxIter', 100); % set optimizer options
x0 = [8 8]; %initial guess [X Y]

% Starting guess for [X Y]
[x,resnorm,exitflag,residual,output] = lsqnonlin(@jaggedterrain,x0, [], [], OPTIONS)    % Invoke optimizer

x % this is the optimal k and m  pair lsqnonlin found

%**************************** Run the optimization with fmincon

fig3 = figure
figure(fig3)
mesh(X,Y,Z);
hold on
% fig3 = surf(X,Y,Z,'FaceColor','interp',...
%     'EdgeColor','none',...
%     'FaceLighting','phong')
% daspect([5 5 1])
% axis tight
% view(-50,30)
% camlight left

% CAN USE EQUALITY CONSTRAINTS IN X
% x0 = [3 3]; %initial guess [X Y]

% Inequality constraints Ax<=b
A = [1  0;
    -1  0;
     0  1;
     0 -1];
 b = [UB;
     -LB;
      UB;
     -LB];
for i = 1:n,
	x0 = [xr(i) yr(i)]    
	x = fmincon(@jaggedterrain,x0,A,b); % Invoke optimizer
%   line([x0(1) x0(1)], [x0(2) x0(2)], [jaggedterrain2(x0) 2],...
%   'Color','b','LineWidth',2); % show only starting point
% 	line([x(1) x(1)], [x(2) x(2)], [jaggedterrain2(x) 2],...
% 	'Color','k','LineWidth',2); % show only optimized value
% Plot the starting point in blue, and the end point in black of every optimization
    line([x0(1) x0(1) x(1)], [x0(2) x0(2) x(2)], [jaggedterrain2(x0) 2, 2], 'Color','b','LineWidth',2);
	line([x(1) x(1)], [x(2) x(2)], [jaggedterrain2(x) 2], 'Color','k','LineWidth',2);
		if jaggedterrain2(x) >= max(max(Z))
         line([x(1) x(1)], [x(2) x(2)], [jaggedterrain2(x) 3], 'Color','r','LineWidth',4);
		end
end
hold off
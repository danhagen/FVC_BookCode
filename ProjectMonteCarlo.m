clear all 
close all
clc

prompt = 'Enter the players height (inches): ';
Hin = input(prompt);
H = Hin *2.54; % Height in cm 

Lse = .186*H; % Length of upper arm (shoulder to elbow) cm
Lf = .146*H; % Length of forearm cm
Lh = .108*H; % Length of hand

q1 = -pi/6: .05: pi;
q2 = 0: .05: 3*pi/4;
q3 = -pi/4: .05: pi/2;
row = length(q1);
col = length(q2);
depth = length(q3);
X = [];
Y = [];

for i = 1:row
    for j = 1:col
        for k = 1:depth
            Y(i,j,k) = -Lse*cos(q1(i))-Lf*cos(q1(i)+q2(j))-Lh*cos(q1(i)+q2(j)-q3(k));
            X(i,j,k) = Lse*sin(q1(i))+Lf*sin(q1(i)+q2(j))+Lh*sin(q1(i)+q2(j)-q3(k));
        end
    end
end

x = [];
y = [];

for i = 1:col
    for j = 1:depth
        x = [x; X(:, i, j)];
        y = [y; Y(:, i, j)];
    end 
end

D = length(x);
% for i = 1 : row
%     xx(i, :) = x(1+(i-1)*D/row:i*D/row);
%     yy(i, :) = y(1+(i-1)*D/row:i*D/row);
% end
% 
% figure
% z = zeros(size(xx));
% mesh(xx, yy, z)

scatter(x,y)

        
